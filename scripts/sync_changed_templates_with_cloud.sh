#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# shellcheck disable=SC2153
main() {
  WIREMOCK_CLOUD_URL=$1
  WIREMOCK_CLOUD_SECRET_ID=$2
  WIREMOCK_CLOUD_API_TOKEN="$(aws secretsmanager get-secret-value --secret-id "$WIREMOCK_CLOUD_SECRET_ID" | jq -r .SecretString | jq -r .teamUserApiKey)"

  cd "$(git rev-parse --show-toplevel)"
  delete_deleted_templates
  update_changed_templates
}

delete_deleted_templates() {
  local deleted_api_template_metadata_files; deleted_api_template_metadata_files="$(git diff --relative=api --diff-filter=D --name-only HEAD~1 | { grep '\-metadata\.json$' || true; })"
  for deleted_api_template_metadata_file in $deleted_api_template_metadata_files; do
    local slug; slug="$(git show HEAD~1:"api/$deleted_api_template_metadata_file" | jq -r .slug)"
    if delete_template "$slug"; then
      echo "Deleted API $slug found in $deleted_api_template_metadata_file"
    else
      echo "Failed to delete API $slug found in $deleted_api_template_metadata_file"
    fi
  done
}

delete_template() {
  local slug=$1
  curl_auth \
    -X DELETE \
    "$WIREMOCK_CLOUD_URL/v1/api-templates/catalogues/public/$slug">/dev/null
}

update_changed_templates() {
  local changed_api_template_dirs; changed_api_template_dirs=$(find_changed_api_template_dirs | uniq)
  for changed_api_template_dir in $changed_api_template_dirs; do
    update_template "$changed_api_template_dir"
  done
}

find_changed_api_template_dirs() {
  local changed_api_template_files; changed_api_template_files="$(git diff --relative=api --name-only HEAD~1)"
  for changed_api_template_files in $changed_api_template_files; do
    echo "${changed_api_template_files%/*}"
  done
}

update_template() {
  local changed_api_template_dir=$1

  local metadata; metadata=("api/$changed_api_template_dir"/*-metadata.json)

  if [[ ${#metadata[@]} -eq 1 ]] && [[ -f "${metadata[0]}" ]] ; then
    put_template "${metadata[0]}"
  fi
}

put_template() {
  local metadata=$1
  local changed_api_template_dir="${metadata%/*}"

  local slug; slug=$(jq -r .slug < "$metadata")
  local logo; logo=$(jq -r '.logo' < "$metadata")
  local logoData; logoData="$(base64 < "$changed_api_template_dir/$logo")"

  local data; data="$(jq "{apiTemplate: { slug: .slug, name: .name, provider: .provider, description: .description, tags: .tags, logoData: \"$logoData\", logoMediaType: .logoMediaType } }" < "$metadata")"
  local apiTemplate; if apiTemplate="$( \
    curl_auth \
      -H 'Content-Type: application/json' \
      -X PUT \
      -d "$data" \
      "$WIREMOCK_CLOUD_URL/v1/api-templates/catalogues/public/$slug" \
  )"; then
    put_stubs "$metadata" "$apiTemplate"
  else
    echo "Failed to PUT /v1/api-templates/catalogues/public/$slug"
  fi
}

put_stubs() {
  local metadata=$1
  local apiTemplate=$2

  local apiTemplateId; apiTemplateId="$(echo "$apiTemplate" | jq -r .apiTemplate.id)"
  local apiTemplateDetails; apiTemplateDetails="$(echo "$apiTemplate" | jq -c '{ apiTemplate: { id: .apiTemplate.id, slug: .apiTemplate.slug, name: .apiTemplate.name, provider: .apiTemplate.provider, tags: .apiTemplate.tags } }')"

  local stubsFile; stubsFile="$changed_api_template_dir/$(jq -r '.stubs' < "$metadata")"

  if curl_auth \
    -H 'Content-Type: application/json' \
    -X PUT \
    -d "@$stubsFile" \
    "$WIREMOCK_CLOUD_URL/v1/api-templates/$apiTemplateId/stubs" >/dev/null; then

    echo "Updated $metadata"
  else
    echo "Failed to PUT /v1/api-templates/$apiTemplateId/stubs"
  fi
}

curl_auth() {
  curl -sS \
    -u "team@wiremock.io:$WIREMOCK_CLOUD_API_TOKEN" \
    "$@"
}

main "$@"
