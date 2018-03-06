afl=$(nix-build --no-out-link '<nixpkgs>' -A afl)
aflNix=$(nix-build --no-out-link -A aflBuild)

fuzzArgs="--eval --strict --option restrict-eval true --dry-run"

export NIX_PATH=r=$(readlink -f .)
export AFL_SKIP_CPUFREQ=1
export GC_INITIAL_HEAP_SIZE=$(( 8 * 1024 * 1024 ))
