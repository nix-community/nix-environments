{
  pkgs ? import <nixpkgs> { config.allowUnfree = true; },
  extraPkgs ? [ ],
}:
pkgs.lib.warnOnInstantiate
  ''
    This shell.nix likely don't work anymore before gcc-arm-embedded-10 got removed from nixpkgs. It may be possible to fix this by adding a gcc-arm-embedded-10 package back similar to https://github.com/NixOS/nixpkgs/pull/385908
    or if upstream switches to a new compiler version: https://github.com/InfiniTimeOrg/InfiniTime/blob/main/doc/buildAndProgram.md
  ''
  (
    pkgs.mkShell {
      nativeBuildInputs =
        with pkgs;
        [
          # TODO: according to upstream this should be gcc-arm-embedded-10
          gcc-arm-embedded-14
          nrf5-sdk
          zlib
          cmake
          gcc10
          adafruit-nrfutil
          mcuboot-imgtool
          (python3.withPackages (python: [
            python.cbor
            python.intelhex
            python.click
            python.cryptography
            python.pillow
          ]))
          nodePackages.lv_font_conv
        ]
        ++ extraPkgs;
    }
  )
