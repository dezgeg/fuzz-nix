#!/usr/bin/env bash

export NIX_PATH=foo=$(readlink -f .)

rm -rf minimized-tmin
mkdir -p minimized-tmin

for f in $(cd corpus && echo *.txt); do
    AFL_SKIP_CPUFREQ=1 $(nix-build --no-out-link ~/opt/nixpkgs -A afl)/bin/afl-tmin -i corpus/$f -o minimized-tmin/$f -m 300 result/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run @@
done
vimdiff <(cd corpus && grep '.*' *.txt) <(cd minimized-tmin && grep '.*' *.txt)
