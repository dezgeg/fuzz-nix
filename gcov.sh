#!/usr/bin/env bash

gcovNix=$(nix-build --no-out-link -A gcovBuild)
lcov=$(nix-build '<nixpkgs>' --no-out-link -A lcov)

export PATH=$(nix-build '<nixpkgs>' --no-out-link -A gcc-unwrapped)/bin:$PATH

source common.sh

dir=inputs/corpus
if [ -n "$1" ]; then
    dir="$1"
fi

rm -rf gcov-prefix htmlcov
mkdir -p gcov-prefix
export GCOV_PREFIX=$(readlink -f gcov-prefix)

for f in $dir/*; do
    $gcovNix/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run $f
done

(
    cd $GCOV_PREFIX
    storepath=$(echo nix/store/*)
    for d in $(find /$storepath -type d); do
        d=$(echo "$d" | sed -e 's|^/||')
        mkdir -p $d
    done

    for srcfile in $(find /$storepath -name '*.c' -o -name '*.cc' -o -name '*.hh' -o -name '*.h' -o -name '*.gcno'); do
        srcfile=$(echo "$srcfile" | sed -e 's|^/||')
        cp /$srcfile $srcfile
    done

    $lcov/bin/lcov -d . -c -o coverage.info
    $lcov/bin/genhtml coverage.info -o ../htmlcov --ignore-errors source
)

