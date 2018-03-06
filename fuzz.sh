#!/usr/bin/env bash

source common.sh

$afl/bin/afl-fuzz -i inputs/corpus -x inputs/dict -o findings -m 300 $aflNix/bin/nix-instantiate $fuzzArgs @@
