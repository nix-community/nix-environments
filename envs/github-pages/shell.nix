{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "env";

  buildInputs = with pkgs; [
    libxslt
    ruby
    bashInteractive
    zlib
    pkg-config
    libxml2
    bundler
  ];
}
