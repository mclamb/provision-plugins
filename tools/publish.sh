#!/usr/bin/env bash

set -e

version=$(tools/version.sh)

# Put docs in place
mkdir -p rebar-catalog/docs
cp cmds/*/*.rst rebar-catalog/docs

ls cmds | while read cmd ; do
    arches=("amd64")
    oses=("linux" "darwin")
    for arch in "${arches[@]}"; do
        for os in "${oses[@]}"; do
            path="$cmd/$version/$arch/$os"
            mkdir -p "rebar-catalog/$path"
            [[ -f  bin/$os/$arch/$cmd ]] || continue
            cp "bin/$os/$arch/$cmd" "rebar-catalog/$path"
        done
    done
done

