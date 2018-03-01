#!/usr/bin/env bash

source common.sh

if [ "$#" -gt 0 ]; then
    inputDir="$1"
else
    inputDir="inputs/corpus"
fi

rm -rf minimized-cmin
$afl/bin/afl-cmin -i "$inputDir" -o minimized-cmin -m 300 $aflNix/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run @@
vimdiff <(cd "$inputDir" && grep '.*' *) <(cd minimized-cmin && grep '.*' *)
