# Nix-environments

Repository to maintain out-of-tree shell.nix files.

For some projects it is non-trivial to get a minimal develop environment that work with Nix/NixOS.
The purpose of this repository is to share shell.nix expression that help to get started with those projects.
The goal of the project is not to build or package those projects (which is often even harder)
but to document the build requirements.

What environments should include:

- dependencies to build, develop or test the project

What environments should **not** include:

- opinionated, user-specific dependencies for example editors or favorite debugging tools

## Current available environments

| Name                                            | Attribute             |
|-------------------------------------------------|-----------------------|
| [Arduino](envs/arduino)                         | `arduino`             |
| [Jruby](envs/jruby)                             | `jruby`               |
| [Github Pages](envs/github-pages)               | `github-pages`        |
| [Homeassistant](envs/home-assistant)            | `home-assistant`      |
| [Nannou](envs/nannou)                           | `nannou`              |
| [Phoronix test suite](envs/phoronix-test-suite) | `phoronix-test-suite` |
| [OpenWRT](envs/openwrt)                         | `openwrt`             |
| [SPEC benchmark](envs/spec-benchmark)           | `spec-benchmark`      |
| [Yocto](envs/yocto)                             | `yocto`               |
| [Xilinx vitis](envs/xilinx-vitis)               | `xilinx-vitis`        |

## How to use

### Stable Nix

All environments referenced in [default.nix](default.nix) can be loaded by running nix-shell like that:

```console
$ nix-shell https://github.com/nix-community/nix-environments/archive/master.tar.gz -A PROJECT_NAME
```

for example openwrt:

```console
$ nix-shell https://github.com/nix-community/nix-environments/archive/master.tar.gz -A openwrt
```

To apply custom modification one can also import environments into their own `shell.nix` files and
override them. Note that this approach does currently not work for buildFHSUserEnv-based environments!

```nix
{ pkgs ? import <nixpkgs> {} }:
let
  envs = (import (builtins.fetchTarball {
    url = "https://github.com/nix-community/nix-environments/archive/master.tar.gz";
  }));
  phoronix = envs.phoronix-test-suite { inherit pkgs; };
in (phoronix.overrideAttrs (old: {
  # this will append python to the existing dependencies
  buildInputs = old.buildInputs ++ [ pkgs.python3 ];
}))
```

### Nix Flakes

Nix-environments are also available as Flake outputs. Flakes are an [experimental new way to handle Nix expressions](https://nixos.wiki/wiki/Flakes).

For dropping into the environment for the OpenWRT project, just run:

```
nix develop --no-write-lock-file github:nix-community/nix-environments#openwrt
```

The last part is a flake URL and is an abbreviation of `github:nix-community/nix-environments#devShells.SYSTEM.openwrt`, where `SYSTEM` is your current system, e.g. `x86_64-linux`.

You can also use these environments in your own flake and extend them:

```nix
{
  inputs.nix-environments.url = "github:nix-community/nix-environments";

  outputs = { self, nixpkgs, nix-environments }: let
    # Replace this string with your actual system, e.g. "x86_64-linux"
    system = "SYSTEM";
  in {
    devShell.${system} = let
        pkgs = import nixpkgs { inherit system; };
      in nix-environments.devShells.${system}.phoronix-test-suite.overrideAttrs (old: {
        buildInputs = old.buildInputs ++ [ pkgs.python3 ];
      });
  };
}
```

## Similar projects

- generates generic templates for different languages: https://github.com/kampka/nixify
- also templates for different languages: https://github.com/mrVanDalo/nix-shell-mix
- templates for flakes: https://github.com/NixOS/templates
