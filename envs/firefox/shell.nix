{ pkgs ? import <nixpkgs> { }
, extraPkgs ? [ ]
}:
let
  # Target the LLVM version that rustc is built with for LTO.
  llvmPackages0 = pkgs.rustc.llvmPackages;

  # Force the use of lld and other llvm tools for LTO
  llvmPackages = llvmPackages0.override {
    bootBintoolsNoLibc = null;
    bootBintools = null;
  };

  # LTO requires LLVM bintools including ld.lld and llvm-ar.
  buildStdenv = pkgs.overrideCC llvmPackages.stdenv (llvmPackages.stdenv.cc.override {
    bintools = pkgs.buildPackages.rustc.llvmPackages.bintools;
  });
in
buildStdenv.mkDerivation {
  name = "env";
  nativeBuildInputs = [
    pkgs.bashInteractive
    pkgs.mercurial
    pkgs.rustc
    pkgs.cargo
    pkgs.unzip
    pkgs.m4
    pkgs.pkg-config
    pkgs.python3
  ] ++ pkgs.lib.optional (!pkgs.stdenv.isDarwin) pkgs.libnotify
  ++ extraPkgs;
}
