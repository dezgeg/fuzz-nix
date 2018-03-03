#!/usr/bin/env bash

source common.sh

$afl/bin/afl-plot findings/ aflgraph
