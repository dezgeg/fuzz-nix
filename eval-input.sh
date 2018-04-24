#!/usr/bin/env bash

source common.sh

exec $aflNix/bin/nix-instantiate $fuzzArgs "$1"
