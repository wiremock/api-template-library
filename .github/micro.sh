#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC2153
main() {
  cd /"$HOME"/wiremock/api-template-library/api/
  api_templates_deleted_in_current_branch=$(git diff --relative=api --diff-filter=D --name-only HEAD~1 | grep  '.*metadata.json')
  for deleted_file in $api_templates_deleted_in_current_branch; do
    (delete_api_template "$deleted_file")
  done
}

delete_api_template() {
  filePath=$1
  local slug; slug=$(basename -- "$filePath")
  echo "Deleting templates: $filePath via DELETE to dev/v1/api-templates/catalogues/public/{slug}"
  local deleted_api_template; deleted_api_template="$( \
           curl --request DELETE \
             -H 'Content-Type: application/json' \
             -H "Authorization: token"\
             "dev/v1/api-templates/catalogues/public/$slug" \
         )"
  echo "Deleted api templates $deleted_api_template"
}

main "$@"