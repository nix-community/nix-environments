# [ZMK](https://zmk.dev)

This example will build the planck_rev6 keyboard,
according to https://zmk.dev/docs/development/local-toolchain/build-flash tutorial

```console
$ git clone https://github.com/zmkfirmware/zmk.git
$ cd zmk
$ west init -l app && west update && west zephyr-export
$ cd app
$ west build -b planck_rev6
```
