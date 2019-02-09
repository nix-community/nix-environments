{ pkgs ? import <nixpkgs> {} }: {
  arduino = import ./envs/arduino/shell.nix { inherit pkgs; };
  openwrt = import ./envs/openwrt/shell.nix { inherit pkgs; };
  phoronix-test-suite = import ./envs/phoronix-test-suite/shell.nix { inherit pkgs; };
  spec-benchmark = import ./envs/spec-benchmark/shell.nix { inherit pkgs; };
  github-pages = import ./envs/github-pages/shell.nix { inherit pkgs; };
}
