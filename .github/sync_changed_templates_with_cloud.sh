#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC2153
main() {
  local wiremock_cloud_url="$1"
  local wiremock_cloud_api_token="$2"
  cd /"$HOME"/wiremock/api-template-library
  basic_api_template_file_path=/$HOME/wiremock/api-template-library/api/
  modified_api_templates=$(git diff --relative=api --diff-filter=M)
  deleted_api_templates=$(git diff --relative=api --diff-filter=D)
  if [[ $modified_api_templates != '' ]]; then
    (update_all_changed_api_templates "$basic_api_template_file_path" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
  fi

  if [[ $deleted_api_templates != '' ]]; then
    (delete_all_api_templates "$basic_api_template_file_path" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
  fi
}

update_all_changed_api_templates() {
  basic_api_template_file_path=$1
  wiremock_cloud_url=$2
  wiremock_cloud_api_token=$3
  api_changes_in_current_branch=$(git diff --relative=api --diff-filter=M --name-only main)
  while IFS='' read -r changed_file; do
    (update_api_template "$basic_api_template_file_path$changed_file" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
  done <<< "$api_changes_in_current_branch"
}

delete_all_api_templates() {
  basic_api_template_file_path=$1
  wiremock_cloud_url=$2
  wiremock_cloud_api_token=$3
  api_templates_deleted_in_current_branch=$(git diff --relative=api --diff-filter=D --name-only main)
  while IFS='' read -r changed_file; do
    (delete_api_template "$basic_api_template_file_path$changed_file" "$wiremock_cloud_url" "$wiremock_cloud_api_token")
  done <<< "$api_templates_deleted_in_current_branch"
}

update_api_template() {
   filePaths=$1
   wiremock_cloud_url=$2
   wiremock_cloud_api_token=$3
   declare paths=()
   read -r -a paths <<< "$filePaths"
   for path in "${paths[@]}"; do
     local slug; slug=$(jq -r '.slug' < "$path")
     local data; data="$(jq '{ apiTemplate: { slug: .slug, name: .name, provider: .provider, description: .description, logoData: .logo,  logoMediaType: .logoMediaType} }'< "$path")"
     echo "Updating template: $path via PUT to $wiremock_cloud_url/v1/api-templates/catalogues/public/{slug}"
     echo "Body: $data"
     local updated_api_template; updated_api_template="$( \
           curl_auth \
              PUT \
             -H 'Content-Type: application/json' \
             -H "Authorization: $wiremock_cloud_api_token"\
             -d "$data" \
             "$wiremock_cloud_url/v1/api-templates/catalogues/public/$slug" \
         )"
    echo "Updated api template $updated_api_template"
   done
}

delete_api_template() {
  filePaths=$1
  wiremock_cloud_url=$2
  wiremock_cloud_api_token=$3
  declare paths=()
  read -r -a paths <<< "$filePaths"
  for path in "${paths[@]}"; do
    local slug; slug=$(jq -r '.slug' < "$path")
    echo "Deleting templates: $path via DELETE to $wiremock_cloud_url/v1/api-templates/catalogues/public/{slug}"
    local deleted_api_template; deleted_api_template="$( \
           curl_auth \
              DELETE \
             -H 'Content-Type: application/json' \
             -H "Authorization: $wiremock_cloud_api_token"\
             "$wiremock_cloud_url/v1/api-templates/catalogues/public/$slug" \
         )"
      echo "Deleted api templates $deleted_api_template"
     done
}

curl_auth() {
  local request_method=$1

  shift
  shift

  curl --request "$request_method" \
    "$@"
}

main "$@"