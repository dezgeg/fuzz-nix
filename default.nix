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
in {
  aflBuild = nix.overrideAttrs (oldAttrs: {
    buildInputs = [ aflSetupHook ] ++ oldAttrs.buildInputs;
  });
}
