let
  pkgs = import <nixpkgs> {};
  nix = (import ./nix/release.nix {}).build.x86_64-linux;

  aflSetupHook = pkgs.makeSetupHook {} (pkgs.writeText "afl-hook.sh" ''
      preConfigurePhases+=" aflSetupPhase"

      aflSetupPhase() {
        export CC=${pkgs.afl}/bin/afl-gcc
        export CXX=${pkgs.afl}/bin/afl-g++
        export CFLAGS="-O3 -funroll-loops"
      }
  '');

  gcovSetupHook = pkgs.makeSetupHook {} (pkgs.writeText "gcov-hook.sh" ''
      postPhases+=" cleanDotBuild"
			export NIX_SET_BUILD_ID=1
			export NIX_CFLAGS_COMPILE+=" -Og -ggdb --coverage"
			dontStrip=1

      cleanDotBuild() {
          if ! [ -e $out/.build ]; then return; fi

          find $out/.build/ -type f -a ! \
              \( -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.h" -o -name "*.hh" -o -name "*.y" -o -name "*.l" -o -name "*.gcno" \) \
              | xargs rm -f --
      }
  '');
in {
  aflBuild = nix.overrideAttrs (oldAttrs: {
    buildInputs = [ aflSetupHook ] ++ oldAttrs.buildInputs;
  });

  gcovBuild = nix.overrideAttrs (oldAttrs: {
    buildInputs = [ pkgs.keepBuildTree gcovSetupHook ] ++ oldAttrs.buildInputs;
  });
}
