#!/usr/bin/env bash

source common.sh

$AFL/bin/afl-fuzz -i inputs/corpus -x inputs/dict -o findings -m 300 result/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run @@
