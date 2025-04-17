{ pkgs ? import <nixpkgs> {}
, extraPkgs ? []
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    bashInteractive
    pkg-config
    autoreconfHook
    python313
    libjpeg
    libxslt
    doxygen
    graphviz
    isa-l
    zlib-ng
  ];
  # fix homeassistant-pyozw build
  NIX_CFLAGS_COMPILE = [ "-Wno-error=format-security" ];
  LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [ stdenv.cc.cc libjpeg ];
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
