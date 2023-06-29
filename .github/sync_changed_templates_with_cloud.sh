#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC2153
main() {
  local wiremock_cloud_url=$1
  local wiremock_cloud_api_token=; wiremock_cloud_api_token="$(aws secretsmanager get-secret-value --secret-id wiremock.cloud/live/system | jq -r .SecretString | jq -r .apiToken)"
  cd /"$HOME"/wiremock/api-template-library/api
  basic_api_template_file_path=/$HOME/wiremock/api-template-library/api/
  added_api_templates=$(git diff --relative=api --diff-filter=A HEAD~1)
  modified_api_templates=$(git diff --relative=api --diff-filter=M HEAD~1)
  deleted_api_templates=$(git diff --relative=api --diff-filter=D HEAD~1)
  if [[ $added_api_templates != '' ]]; then
    (add_new_api_templates "$basic_api_template_file_path" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
  fi

  if [[ $modified_api_templates != '' ]]; then
    (update_all_changed_api_templates "$basic_api_template_file_path" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
  fi

  if [[ $deleted_api_templates != '' ]]; then
    (delete_all_api_templates "$basic_api_template_file_path" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
  fi
}

add_new_api_templates() {
    basic_api_template_file_path=$1
    wiremock_cloud_url=$2
    wiremock_cloud_api_token=$3
    added_files_in_current_branch=$(git diff --relative=api --diff-filter=A --name-only HEAD~1)
    for added_file in $added_files_in_current_branch; do
      if [[ $added_file == *"metadata.json"* ]]; then
        api_template_namespace=$(dirname "$added_file")
        if [[ -n "$(echo "$api_changes_in_current_branch" | grep  "$api_template_namespace.*-logo.*")" ]]; then
          logo=$(echo "$added_files_in_current_branch" | grep  "$api_template_namespace.*-logo.*")
          encoded_logo=$(base64 "$logo")
          (add_api_template "$added_file" "$encoded_logo" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
        else
          (add_api_template "$added_file" "" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
        fi
      fi
    done
}

#maybe change url
add_api_template() {
    pathName=$1
    logo=$2
    wiremock_cloud_url=$3
    wiremock_cloud_api_token=$4
    echo "Adding new api template: $pathName via POST to $wiremock_cloud_url/v1/api-templates"
    declare metadata_info=''
    metadata_info=$(<"$pathName")
    local data; data="$(jq '{ apiTemplate: { slug: .slug, name: .name, provider: .provider, description: .description, logoMediaType: .logoMediaType} }'<<< "$metadata_info")"
    local final_body;
      if [[ $logo != '' ]]; then
        data_with_logo=$(jq --arg parent_key apiTemplate \
             --arg child_key logoData \
             --arg child_val "$logo" \
             '.[$parent_key] += {($child_key): $child_val}' <<< "$data")
        final_body=$data_with_logo
      else
        final_body=$data
    fi
    echo "Body: $final_body"
    local created_api_template; created_api_template="$( \
    curl --request POST \
            -H 'Content-Type: application/json' \
            -H "Authorization: $wiremock_cloud_api_token"\
            -d "$data_with_logo" \
             "$wiremock_cloud_url/v1/api-templates" \
    )"
    echo "Created api template $created_api_template"
}

update_all_changed_api_templates() {
  basic_api_template_file_path=$1
  wiremock_cloud_url=$2
  wiremock_cloud_api_token=$3
  api_changes_in_current_branch=$(git diff --relative=api --diff-filter=M --name-only HEAD~1)
  for changed_file in $api_changes_in_current_branch; do
    if [[ $changed_file == *"metadata.json"* ]]; then
      api_template_namespace=$(dirname "$changed_file")
      if [[ -n "$(echo "$api_changes_in_current_branch" | grep  "$api_template_namespace.*-logo.*")" ]]; then
        logo=$(echo "$api_changes_in_current_branch" | grep  "$api_template_namespace.*-logo.*")
        encoded_logo=$(base64 "$logo")
        (update_api_template "$basic_api_template_file_path$changed_file" "$encoded_logo" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
      else
        (update_api_template "$basic_api_template_file_path$changed_file" "" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
      fi
    fi
  done
}

update_api_template() {
   pathName=$1
   logo=$2
   wiremock_cloud_url=$3
   wiremock_cloud_api_token=$4
   echo "Updating template: $pathName via PUT to dev/v1/api-templates/catalogues/public/{slug}"
   declare metadata_info=''
   metadata_info=$(<"$pathName")
   local slug; slug=$(jq '.slug' <<< "$metadata_info")
   local data; data="$(jq '{ apiTemplate: { slug: .slug, name: .name, provider: .provider, description: .description, logoMediaType: .logoMediaType} }'<<< "$metadata_info")"
   local final_body;
   if [[ $logo != '' ]]; then
     final_body=$(jq --arg parent_key apiTemplate \
          --arg child_key logoData \
          --arg child_val "$logo" \
          '.[$parent_key] += {($child_key): $child_val}' <<< "$data")
   else
     final_body=$data
   fi
   echo "Body: $final_body"
   local updated_api_template; updated_api_template="$( \
   curl --request PUT \
        -H 'Content-Type: application/json' \
        -H "Authorization: $wiremock_cloud_api_token"\
        -d "$final_body" \
         "$wiremock_cloud_url/v1/api-templates/catalogues/public/$slug" \
      )"
   echo "Updated api template $updated_api_template"
}

delete_all_api_templates() {
  basic_api_template_file_path=$1
  wiremock_cloud_url=$2
  wiremock_cloud_api_token=$3
  api_templates_deleted_in_current_branch=$(git diff --relative=api --diff-filter=D --name-only HEAD~1 | grep  '.*metadata.json')
  for deleted_file in $api_templates_deleted_in_current_branch; do
    (delete_api_template "$basic_api_template_file_path$deleted_file" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
  done
}

delete_api_template() {
  filePath=$1
  wiremock_cloud_url=$2
  wiremock_cloud_api_token=$3
  echo "Deleting templates: $filePath via DELETE to $wiremock_cloud_url/v1/api-templates/catalogues/public/{slug}"
  local slug; slug=$(basename -- "$filePath")
  local deleted_api_template; deleted_api_template="$( \
           curl --request DELETE \
             -H 'Content-Type: application/json' \
             -H "Authorization: $wiremock_cloud_api_token"\
             "$wiremock_cloud_url/v1/api-templates/catalogues/public/$slug" \
         )"
  echo "Deleted api templates $deleted_api_template"
}

main "$@"
