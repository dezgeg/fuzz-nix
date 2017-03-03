#!/usr/bin/env bash

rm -rf findings2

AFL_SKIP_CPUFREQ=1 $(nix-build --no-out-link '<nixpkgs>' -A afl)/bin/afl-fuzz -i corpus -x dict -o findings2 -m 100 result/bin/nix-instantiate --eval --strict --option restrict-eval true @@
