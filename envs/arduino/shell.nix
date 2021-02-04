{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSUserEnv {
  name = "arduino-env";
  targetPkgs = pkgs: with pkgs; [
    ncurses
    arduino
    zlib
    (python3.withPackages(ps: [
      ps.pyserial
    ]))
  ];
  multiPkgs = null;
}).env
