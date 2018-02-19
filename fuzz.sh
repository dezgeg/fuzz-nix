#!/usr/bin/env bash

source common.sh

rm -rf findings

$AFL/bin/afl-fuzz -i corpus -x dict -o findings -m 300 result/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run @@
