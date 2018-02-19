#!/usr/bin/env bash

source common.sh

rm -rf minimized-tmin
mkdir -p minimized-tmin

for f in $(cd corpus && echo *.txt); do
    $AFL/bin/afl-tmin -i corpus/$f -o minimized-tmin/$f -m 300 result/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run @@ || break
done
vimdiff <(cd corpus && grep '.*' *.txt) <(cd minimized-tmin && grep '.*' *.txt)
