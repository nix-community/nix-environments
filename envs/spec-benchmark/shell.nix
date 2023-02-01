{ pkgs ? import <nixpkgs> {}
, extraPkgs ? []
}:

let
  specgcc = pkgs.gcc6;

  fixWrapper = pkgs.runCommand "fix-wrapper" {} ''
    mkdir -p $out/bin
    for i in ${specgcc.cc}/bin/*-gnu-gcc*; do
      ln -s ${specgcc}/bin/gcc $out/bin/$(basename "$i")
    done
    for i in ${specgcc.cc}/bin/*-gnu-{g++,c++}*; do
      ln -s ${specgcc}/bin/g++ $out/bin/$(basename "$i")
    done
  '';

  fhs = pkgs.buildFHSUserEnv {
    name = "spec-env";
    targetPkgs = pkgs: with pkgs; [
      # higher priority then the default gcc
      (hiPrio specgcc)
      perl
      gnumake
      gfortran
      gnutar
      which
      fixWrapper
      binutils
    ] ++ extraPkgs;
    multiPkgs = null;
    extraOutputsToInstall = [ "dev" ];
    profile = ''
      export hardeningDisable=all
    '';
  };
in fhs.env
