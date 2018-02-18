#!/usr/bin/env bash

export NIX_PATH=foo=$(readlink -f .)

rm -rf minimized-cmin
AFL_SKIP_CPUFREQ=1 $(nix-build --no-out-link ~/opt/nixpkgs -A afl)/bin/afl-cmin -i corpus -o minimized-cmin -m 300 result/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run @@
vimdiff <(cd corpus && grep '.*' *.txt) <(cd minimized-cmin && grep '.*' *.txt)
