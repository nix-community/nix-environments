{ pkgs ? import <nixpkgs> {
    config.allowUnfree = true;
}, extraPkgs ? []
}:

(pkgs.buildFHSUserEnv {
  name = "infinitime-env";
  targetPkgs = pkgs: with pkgs; [
    gcc-arm-embedded-10
    nrf5-sdk
    zlib
    cmake
    gcc10
    (python3.withPackages(python: [
      python.cbor
      python.intelhex
      python.click
      python.cryptography
      python.imgtool
    ]))
    nodePackages.lv_font_conv
  ] ++ extraPkgs;
  multiPkgs = null;
}).env
