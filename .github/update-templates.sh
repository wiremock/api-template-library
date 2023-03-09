#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC2153
main() {
  local wiremock_cloud_url="$WIREMOCK_CLOUD_URL"
  local wiremock_cloud_username="$WIREMOCK_CLOUD_USERNAME"
  local wiremock_cloud_api_token="$WIREMOCK_CLOUD_API_TOKEN"

  updateAll "$wiremock_cloud_url" "$wiremock_cloud_username" "$wiremock_cloud_api_token"
}

updateAll() {
  local wiremock_cloud_url=$1
  local wiremock_cloud_username=$2
  local wiremock_cloud_api_token=$3

  for dir in ../*; do
    if [[ -d "$dir" ]]; then
      update "${dir#../}" "$wiremock_cloud_url" "$wiremock_cloud_username" "$wiremock_cloud_api_token"
    fi
  done
}

update() {
  local dir=$1
  local wiremock_cloud_url=$2
  local wiremock_cloud_username=$3
  local wiremock_cloud_api_token=$4

  local metadata; metadata="../$dir/$dir-metadata.json"

  local logo; logo=$(jq -r '.logo' < "$metadata")
  local logoData; logoData="$(base64 < "../$dir/$logo")"

  local data; data="$(jq "{apiTemplate: { slug: .slug, name: .title, description: .description, tags: .tags, logoData: \"$logoData\", logoMediaType: .logoMediaType } }" < "$metadata")"

  echo "Creating template: $dir via POST to $wiremock_cloud_url/v1/api-templates/public"

  local apiTemplate; apiTemplate="$( \
    curl_auth \
      "$wiremock_cloud_username" \
      "$wiremock_cloud_api_token" \
      -H 'Content-Type: application/json' \
      -d "$data" \
      "$wiremock_cloud_url/v1/api-templates/public" \
  )"

  local apiTemplateId; apiTemplateId="$(echo "$apiTemplate" | jq -r .apiTemplate.id)"
  local apiTemplateDetails; apiTemplateDetails="$(echo "$apiTemplate" | jq -c '{ apiTemplate: { id: .apiTemplate.id, slug: .apiTemplate.slug, name: .apiTemplate.name, description: .apiTemplate.description, tags: .apiTemplate.tags } }')"

  echo "Created $apiTemplateDetails"

  local stubsFile; stubsFile="../$dir/$(jq -r '.stubs' < "$metadata")"

  echo "Setting stubs: $stubsFile for template $dir via PUT to $wiremock_cloud_url/v1/api-templates/$apiTemplateId/stubs"

  curl_auth \
    "$wiremock_cloud_username" \
    "$wiremock_cloud_api_token" \
    -H 'Content-Type: application/json' \
    -X PUT \
    -d "@$stubsFile" \
    "$wiremock_cloud_url/v1/api-templates/$apiTemplateId/stubs" >/dev/null
}

curl_auth() {
  local wiremock_cloud_username=$1
  local wiremock_cloud_api_token=$2

  shift
  shift

  curl -sS --fail-with-body \
    -u "$wiremock_cloud_username:$wiremock_cloud_api_token" \
    "$@"
}

update "$@"
