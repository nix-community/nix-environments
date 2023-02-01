#  A Creative Coding Framework for Rust.
{ pkgs ? import <nixpkgs> {}
, extraPkgs ? []
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    cargo
    rustc
    pkg-config
    alsa-lib
    cmake
    openssl
    xorg.libxcb
  ] ++ extraPkgs;
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    vulkan-loader
  ]);
}

