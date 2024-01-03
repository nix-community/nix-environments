# Firefox development environment

**Disclaimer:** This setup currently also requies nix-ld (https://github.com/Mic92/nix-ld) to run binaries provided by mozilla.

This [envrc](https://direnv.net/) will setup a virtualenv for the buildsystem:

```
use nix
layout python
export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
```

To clone the repository:

```
$ curl https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py -O
$ python3 bootstrap.py
```

To build & run firefox

```
./mach configure
./mach build
./mach run
```
