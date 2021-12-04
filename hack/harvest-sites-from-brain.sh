#!/usr/bin/env bash

REPO_ROOT=$(git rev-parse --show-toplevel)

HARVEST_KEY='my brain is a fruitful harvest'
HARVEST_MANIFEST_FILE="${REPO_ROOT}/_unzipped_export/${HARVEST_KEY}.md"

echo 'HARVEST_MANIFEST:'
cat "${HARVEST_MANIFEST_FILE}"

echo 'HARVEST_MANIFEST with parsing:'
cat "${HARVEST_MANIFEST_FILE}" | grep -e '\[\[.*\]\]'
