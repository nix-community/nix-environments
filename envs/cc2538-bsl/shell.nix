{ pkgs ? import <nixpkgs> {} }:

let
  python3withDeps = pkgs.python3.buildEnv.override {
    extraLibs = with pkgs; [
      python3Packages.intelhex
      python3Packages.pyserial
      python3Packages.python-magic
    ];
  };
in

pkgs.mkShell {
  buildInputs = [ python3withDeps ];
}
