#!/usr/bin/env bash

rm -rf minimized-cmin
AFL_SKIP_CPUFREQ=1 $(nix-build --no-out-link '<nixpkgs>' -A afl)/bin/afl-cmin -i corpus -o minimized-cmin -m 100 ~/opt/nix/result/bin/nix-instantiate --eval --strict --option restrict-eval true @@
vimdiff <(cd corpus && grep '.*' *.txt) <(cd minimized-cmin && grep '.*' *.txt)
