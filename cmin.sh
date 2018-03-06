#!/usr/bin/env bash

source common.sh

if [ "$#" -gt 0 ]; then
    inputDir="$1"
else
    inputDir="inputs/corpus"
fi

rm -rf minimized-cmin
$afl/bin/afl-cmin -i "$inputDir" -o minimized-cmin -m 300 $aflNix/bin/nix-instantiate $fuzzArgs @@
vimdiff <(cd "$inputDir" && grep -a '.*' *) <(cd minimized-cmin && grep -a '.*' *)
