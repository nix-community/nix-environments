{ pkgs ? import <nixpkgs> {}
, extraPkgs ? []
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    bashInteractive
    pkg-config
    autoreconfHook
    python3.pkgs.setuptools
    python3
    libxslt
    doxygen
    graphviz
  ];
  # fix homeassistant-pyozw build
  NIX_CFLAGS_COMPILE = [ "-Wno-error=format-security" ];
  LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
  buildInputs = with pkgs; [
    gcc
    libxml2
    openssl
    libxslt
    libffi
    udev
    zlib
    ffmpeg
  ] ++ extraPkgs;
}
