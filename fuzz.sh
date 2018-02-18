#!/usr/bin/env bash

export NIX_PATH=foo=$(readlink -f .)

rm -rf findings

AFL_SKIP_CPUFREQ=1 $(nix-build --no-out-link ~/opt/nixpkgs -A afl)/bin/afl-fuzz -i corpus -x dict -o findings -m 300 result/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run @@
