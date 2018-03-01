# fuzz-nix
## TL;DR

This repository provides turn-key scripts & input data for fuzzing the Nix interpreter.

To use:
- Checkout the `nix` submodule. There should be a hacky commit on top of Nix master to make it work.
  (For some reason AFL-compiled code that uses `thread_local` variables doesn't link, seems upstream problem).
- Run `./make-corpus.sh`, see below on what it does.
- Run `./fuzz.sh`.

## Structure of the repo

### Input files
- `corpus/`: The fuzzing corpus. Unlike the usual AFL format of one input per file, the `.txt` contain one input per line.
- `dict/`: The dictionary of tokens used during fuzzing. Same format as above.

### Scripts

- `make-corpus.sh`: Preprocesses the `corpus/` and `dict/` directories to a format suitable for AFL.
- `fuzz.sh`: Starts the fuzzer.
- `cmin.sh`: Run the `afl-cmin`, the test corpus minimizer for all the input files.
- `tmin.sh`: Run the `afl-tmin`, the testcase minimizer for all the input files.
- `gcov.sh`: Measure code coverage of the corpus.

## Bug gallery
- https://github.com/NixOS/nix/commit/1d0e42879fa687a7b6856b1a63070e44bd8ed5c4
- https://github.com/NixOS/nix/commit/546f98dace5c3569211caf392c9dde06a20aa7b0
- https://github.com/NixOS/nix/commit/77e9e1ed91182cb8409d325e225a99decb49b3d5

## TODO
- Figure out parallelized fuzzing.
- Get `afl-clang-fast` working.
    - And the persistent mode.
- Prune out unnecessary stuff from the `nix` process (it currently launches threads for something, for instance).
- Try libFuzzer or other fuzzers.
