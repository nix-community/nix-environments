{ pkgs ? import <nixpkgs> {}
, extraPkgs ? []
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    bashInteractive
    pkg-config
    autoreconfHook
    python312.pkgs.setuptools
    python312
    libxslt
    doxygen
    graphviz
  ];
  # fix homeassistant-pyozw build
  NIX_CFLAGS_COMPILE = [ "-Wno-error=format-security" ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
  buildInputs = with pkgs; [
    libxml2
    openssl
    libxslt
    libffi
    udev
    zlib
    ffmpeg
  ] ++ extraPkgs;
}
