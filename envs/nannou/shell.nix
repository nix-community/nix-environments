{ pkgs ? import <nixpkgs> }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    cargo
    rustc
    pkg-config
    alsa-lib
    cmake
    openssl
    xlibs.libxcb
  ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    xlibs.libX11
    xlibs.libXcursor
    xlibs.libXrandr
    xlibs.libXi
    vulkan-loader
  ]);
}

