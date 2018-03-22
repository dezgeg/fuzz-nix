#!/usr/bin/env bash

source common.sh

if [ "$#" -gt 0 ]; then
    if [ -d "$1" ]; then
        inputs=$(echo "$1"/*)
    else
        inputs="$@"
    fi
else
    inputs=$(echo inputs/corpus/*)
fi

rm -rf minimized-tmin
mkdir -p minimized-tmin

for f in $inputs; do
    if ! $afl/bin/afl-tmin -i "$f" -o "minimized-tmin/$(basename "$f")" -m 300 $aflNix/bin/nix-instantiate $fuzzArgs @@; then
        cp "$f" "minimized-tmin/$(basename "$f")"
    fi
done
vimdiff <(grep -a '.*' $inputs | perl -pe 's|(?:[^:]+/)?([^:]+):|$1:|') <(cd minimized-tmin && grep -a '.*' *)
