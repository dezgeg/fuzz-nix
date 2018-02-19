#!/usr/bin/env bash

source common.sh

rm -rf minimized-cmin
$AFL/bin/afl-cmin -i corpus -o minimized-cmin -m 300 result/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run @@
vimdiff <(cd corpus && grep '.*' *.txt) <(cd minimized-cmin && grep '.*' *.txt)
