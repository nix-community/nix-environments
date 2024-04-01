{ pkgs ? import <nixpkgs> {}, extraPkgs ? []
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cmake
    gnumake
    SDL2
    libpng
    gcc12
    ccache
    (python3.withPackages(python: [
      python.pillow
    ]))
    nodePackages.lv_font_conv
  ] ++ extraPkgs;
}
