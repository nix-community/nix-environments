{ pkgs ? import <nixpkgs> {} }: {
  openwrt = import ./envs/openwrt/shell.nix { inherit pkgs; };
  phoronix-test-suite = import ./envs/phoronix-test-suite/shell.nix { inherit pkgs; };
  spec = import ./envs/spec/shell.nix { inherit pkgs; };
}
