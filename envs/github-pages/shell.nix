{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "env";

  buildInputs = with pkgs; [
    libxslt
    ruby
    bashInteractive
    zlib
    pkgconfig
    libxml2
    bundler
  ];
}
