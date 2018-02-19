export NIX_PATH=foo=$(readlink -f .)
export AFL_SKIP_CPUFREQ=1
export GC_INITIAL_HEAP_SIZE=$(( 8 * 1024 * 1024 ))

AFL=$(nix-build --no-out-link ~/opt/nixpkgs -A afl)
