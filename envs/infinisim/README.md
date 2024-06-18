# InfiniSim

Build environment for [InfiniSim](https://github.com/InfiniTimeOrg/InfiniSim).

## Building the Project

Build instructions:

```
$ nix-shell
$ cmake -DWITH_PNG=OFF -S . -B build
$ cmake --build build -j6
```

By default the build uses a version of the [InfiniTime sources](https://github.com/InfiniTimeOrg/InfiniTime) in `./InfiniTime` as git submodule. You might want to delete this submodule and use a symlink to a local version of InfiniTime or update the submodule to track your own fork of InfiniTime.

Further build instructions: https://github.com/InfiniTimeOrg/InfiniSim/blob/main/README.md

This `shell.nix` works with `direnv`.
