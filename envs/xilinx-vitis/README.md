# Xilinx vitis

After entering the fhs environment shell provided by

```console
$ nix develop --no-write-lock-file github:nix-community/nix-environments#xilinx-vitis
```

or 

``` console
$ nix-shell https://github.com/nix-community/nix-environments/archive/master.tar.gz -A  xilinx-vitis
```

one can run the web installer downloaded from the xilinx website.
Preferably install Vivitis to `/opt` as the shell here sources from
`/opt/xilinx/Vitis/*/settings64.sh` once vivitis is installed.
After installation close fhs environment shell, open a new one
and try to run vivitis.
