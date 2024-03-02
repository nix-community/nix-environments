# InfiniTime

Build environment for [InfiniTime](https://github.com/InfiniTimeOrg/InfiniTime/issues?q=is%3Aissue+is%3Aopen+gcc).

Note: Uses `unfree` package `nrf5-sdk`!

## Building the Project

Build instructions:

```
$ nix-shell
$ mkdir build
$ cd build
$ cmake -DARM_NONE_EABI_TOOLCHAIN_PATH=/usr -DNRF5_SDK_PATH=/usr/share/nRF5_SDK -DCMAKE_BUILD_TYPE=Release ..
$ make -j6 pinetime-app
```

Note that the `ARM_NONE_EABI_TOOLCHAIN_PATH` is just `/usr` as everything is linked there.

Further build instructions: https://github.com/InfiniTimeOrg/InfiniTime/blob/main/doc/buildAndProgram.md
