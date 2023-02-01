{ pkgs ? import <nixpkgs> {}
, extraPkgs ? []
}:

(pkgs.buildFHSUserEnv {
  name = "arduino-env";
  targetPkgs = pkgs: with pkgs; [
    ncurses
    arduino
    zlib
    (python3.withPackages(ps: [
      ps.pyserial
    ]))
  ] ++ extraPkgs;
  multiPkgs = null;
}).env
