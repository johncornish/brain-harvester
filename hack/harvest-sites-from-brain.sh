#!/usr/bin/env bash

function extractTreesFromFile() {
  file=$1
  cat "${file}" |
    grep -e '\[\[.*\]\]' |
    sed -E 's/^.*- \[\[//g' |
    sed -E 's/]]//g'
}

function moveTreesToSite() {
  local site=$1
  local trees="${@:2}"
}

export -f extractTreesFromFile
export REPO_ROOT=$(git rev-parse --show-toplevel)

HARVEST_KEY='my brain is a fruitful harvest'
HARVEST_MANIFEST_FILE="${REPO_ROOT}/_unzipped_export/${HARVEST_KEY}.md"

TREE_DEF_FILES=$(extractTreesFromFile "${HARVEST_MANIFEST_FILE}")

echo "${TREE_DEF_FILES}" \
  | xargs -I {} -L1 mkdir -p "${REPO_ROOT}/_sites/{}"
echo "${TREE_DEF_FILES}" \
  | xargs -I {} -L1 cp "${REPO_ROOT}/_unzipped_export/{}.md" "${REPO_ROOT}/_sites/{}/index.md"

# move all referenced trees from def files
# no I don't like this but it works
echo "${TREE_DEF_FILES}" |
  xargs -I {} -L1 bash -c 'extractTreesFromFile "${REPO_ROOT}/_unzipped_export/{}.md" | xargs -I :: -L1 cp "${REPO_ROOT}/_unzipped_export/::.md" "${REPO_ROOT}/_sites/{}/"'
