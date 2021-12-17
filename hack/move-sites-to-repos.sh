#!/usr/bin/env bash

export REPO_ROOT=$(git rev-parse --show-toplevel)

sites=$(ls ${REPO_ROOT}/_sites)

IFS=$'\n'
for site in $sites ; do
    dashed_site=${site// /-}
    src_site="${REPO_ROOT}/_sites/${site}"
    dest_site="${REPO_ROOT}/../brain-segments/${dashed_site}/_site"
    mkdir -p $dest_site
    cp -r "${src_site}/" "${dest_site}/"
done
