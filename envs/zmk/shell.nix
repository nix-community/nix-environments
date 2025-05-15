{
  pkgs ? import <nixpkgs> { },
}:
let

  zephyr-nix =
    pkgs.callPackage
      (builtins.fetchTarball {
        url = "https://github.com/adisbladis/zephyr-nix/archive/refs/heads/master.tar.gz";
      })
      {
        pyproject-nix =
          import
            (builtins.fetchTarball {
              url = "https://github.com/pyproject-nix/pyproject.nix/archive/refs/heads/master.tar.gz";
            })
            {
              inherit (pkgs) lib;
            };
        zephyr-src = builtins.fetchTarball {
          url = "https://github.com/zmkfirmware/zephyr/archive/refs/heads/v3.5.0+zmk-fixes.tar.gz";
        };
      };

  inherit (pkgs) cmake ninja mkShell;
in
mkShell {
  buildInputs = [
    zephyr-nix.pythonEnv
    (zephyr-nix.sdk.override {
      targets = [
        "arm-zephyr-eabi"
      ];
    })
    zephyr-nix.hosttools-nix
    cmake
    ninja
  ];
}
