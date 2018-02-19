#!/usr/bin/env bash

export NIX_PATH=foo=$(readlink -f .)

dir=corpus
if [ -n "$1" ]; then
    dir="$1"
fi

rm -rf gcov-prefix htmlcov
export GCOV_PREFIX=$(readlink -f gcov-prefix)

for f in $dir/*; do
    ./result/bin/nix-instantiate --eval --strict --option restrict-eval true --dry-run $f
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

    lcov -d . -c -o coverage.info
    genhtml coverage.info -o ../htmlcov --ignore-errors source
)

