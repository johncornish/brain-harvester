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

HARVEST_KEY='my-brain-is-a-fruitful-harvest'
HARVEST_MANIFEST_FILE="${REPO_ROOT}/_unzipped_export/${HARVEST_KEY}.md"

TREE_DEF_FILES=$(extractTreesFromFile "${HARVEST_MANIFEST_FILE}")

IFS=$'\n'

for tree_def in $TREE_DEF_FILES; do
  mkdir -p "${REPO_ROOT}/_sites/${tree_def}"
  cp "${REPO_ROOT}/_unzipped_export/${tree_def}.md" "${REPO_ROOT}/_sites/${tree_def}/index.md"

  sub_trees=$(extractTreesFromFile "${REPO_ROOT}/_unzipped_export/${tree_def}.md")
  for sub_tree in $sub_trees; do
    cp "${REPO_ROOT}/_unzipped_export/${sub_tree}.md" "${REPO_ROOT}/_sites/${tree_def}/"
  done
done
