{ pkgs ? import <nixpkgs> {}
, runScript ? "bash"
, xilinxName ? "xilinx-env"
}:

(pkgs.buildFHSUserEnv {
  name = xilinxName;
  inherit runScript;
  targetPkgs = pkgs: with pkgs; [
    bash
    coreutils
    zlib
    lsb-release
    stdenv.cc.cc
    ncurses5
    xorg.libXext
    xorg.libX11
    xorg.libXrender
    xorg.libXtst
    xorg.libXi
    xorg.libXft
    xorg.libxcb
    xorg.libxcb
    # common requirements
    freetype
    fontconfig
    glib
    gtk2
    gtk3

    # to compile some xilinx examples
    opencl-clhpp
    ocl-icd
    opencl-headers

    # from installLibs.sh
    graphviz
    (lib.hiPrio gcc)
    unzip
    nettools
  ];
  multiPkgs = null;
  profile = ''
    source /opt/xilinx/Vitis/*/settings64.sh
  '';
}).env
