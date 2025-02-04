{ pkgs ? import <nixpkgs> { }
, extraPkgs ? [ ]
, runScript ? "bash"
, xilinxName ? "xilinx-env"
}:

(pkgs.buildFHSEnv {
  name = xilinxName;
  inherit runScript;
  targetPkgs = pkgs: with pkgs; let
    ncurses' = ncurses5.overrideAttrs (old: {
      configureFlags = old.configureFlags ++ [ "--with-termlib" ];
      postFixup = "";
    });
  in
  [
    bash
    coreutils
    zlib
    lsb-release
    stdenv.cc.cc
    # https://github.com/NixOS/nixpkgs/issues/218534
    # postFixup would create symlinks for the non-unicode version but since it breaks
    # in buildFHSEnv, we just install both variants
    ncurses'
    (ncurses'.override { unicodeSupport = false; })
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
    libxcrypt-legacy # required for Vivado
    python3

    (libidn.overrideAttrs (_old: {
      # we need libidn.so.11 but nixpkgs has libidn.so.12
      src = fetchurl {
        url = "mirror://gnu/libidn/libidn-1.34.tar.gz";
        sha256 = "sha256-Nxnil18vsoYF3zR5w4CvLPSrTpGeFQZSfkx2cK//bjw=";
      };
    }))

    # to compile some xilinx examples
    opencl-clhpp
    ocl-icd
    opencl-headers

    # from installLibs.sh
    graphviz
    (lib.hiPrio gcc)
    unzip
    nettools
  ] ++ extraPkgs;
  multiPkgs = ps: [];
  profile = ''
    export LC_NUMERIC="en_US.UTF-8"
    source /opt/xilinx/Vitis/*/settings64.sh
  '';
}).env
