{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "phoronix-env";
  buildInputs = with pkgs; [
    php
    autoreconfHook
    popt
    libaio
    perl
    gcc7
    pcre
    glibc.out
    glibc.static
    bc
  ];
  hardeningDisable = [ "all" ];
}
