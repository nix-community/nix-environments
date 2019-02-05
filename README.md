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

| Name                                                      | Attribute             |
|-----------------------------------------------------------|-----------------------|
| [Github Pages](envs/github-pages/README.md)               | `github-pages`        |
| [OpenWRT](envs/openwrt/README.md)                         | `openwrt`             |
| [Phoronix test suite](envs/phoronix-test-suite/README.md) | `phoronix-test-suite` |
| [SPEC benchmark](envs/spec-benchmark/README.md)           | `spec-benchmark`      |

## How to use

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

## Similar projects

- generates generic templates for different languages: https://github.com/kampka/nixify
