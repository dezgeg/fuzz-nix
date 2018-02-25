#!/usr/bin/env bash

source common.sh

if [ "$#" -gt 0 ]; then
    inputDir="$1"
else
    inputDir="corpus"
fi

rm -rf minimized-cmin
$AFL/bin/afl-cmin -i "$inputDir" -o minimized-cmin -m 300 result/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run @@
vimdiff <(cd "$inputDir" && grep '.*' *) <(cd minimized-cmin && grep '.*' *)
