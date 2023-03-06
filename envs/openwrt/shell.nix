{ pkgs ? import <nixpkgs> {}
, extraPkgs ? []
}:

let
  fixWrapper = pkgs.runCommand "fix-wrapper" {} ''
    mkdir -p $out/bin
    for i in ${pkgs.gcc.cc}/bin/*-gnu-gcc*; do
      ln -s ${pkgs.gcc}/bin/gcc $out/bin/$(basename "$i")
    done
    for i in ${pkgs.gcc.cc}/bin/*-gnu-{g++,c++}*; do
      ln -s ${pkgs.gcc}/bin/g++ $out/bin/$(basename "$i")
    done
  '';

  fhs = pkgs.buildFHSUserEnv {
    name = "openwrt-env";
    targetPkgs = pkgs: with pkgs; [
      git
      perl
      gnumake
      gcc
      unzip
      util-linux
      python3
      rsync
      patch
      wget
      file
      subversion
      which
      pkg-config
      openssl
      fixWrapper
      systemd
      binutils

      ncurses
      zlib
      zlib.static
      glibc.static
    ] ++ extraPkgs;
    multiPkgs = null;
    extraOutputsToInstall = [ "dev" ];
    profile = ''
      export hardeningDisable=all
    '';
  };
in fhs.env
