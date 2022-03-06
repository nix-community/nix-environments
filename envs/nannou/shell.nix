#  A Creative Coding Framework for Rust.
{ pkgs ? import <nixpkgs> }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    cargo
    rustc
    pkg-config
    alsa-lib
    cmake
    openssl
    xorg.libxcb
  ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    vulkan-loader
  ]);
}

