{ pkgs ? import <nixpkgs> {}
, extraPkgs ? []
}:
let
  fhs = pkgs.buildFHSEnv {
    name = "openwrt-env";
    targetPkgs = p: with p; [
      bash
      bc
      binutils
      bison
      bzip2
      coreutils
      diffutils
      file
      findutils
      flex
      gawk
      gcc
      # Meson (detect_static_linker) prefers gcc-ar over ar when GCC + b_lto=true.
      # gcc-ar automatically loads liblto_plugin.so so libapk.a gets a proper LTO
      # symbol index. Without these, Meson falls back to bare ar and apk fails to
      # link (undefined reference to apk_blob_hash etc.).
      (pkgs.runCommand "gcc-lto-tools" {} ''
        mkdir -p $out/bin
        ln -s ${pkgs.gcc.cc}/bin/gcc-ar      $out/bin/gcc-ar
        ln -s ${pkgs.gcc.cc}/bin/gcc-ranlib  $out/bin/gcc-ranlib
        ln -s ${pkgs.gcc.cc}/bin/gcc-nm      $out/bin/gcc-nm
      '')
      gettext
      git
      glibc           # dev output provides /usr/include (sys/types.h, argp.h, fts.h)
      glibc.static
      gnumake
      gnugrep
      gnused
      gnutar
      gzip
      libxslt         # xsltproc
      ncurses
      openssl
      patch
      perl
      pkg-config
      (python3.withPackages (ps: [ ps.setuptools ]))
      quilt
      rsync
      swig
      unzip
      util-linux      # getopt --long, checked by prereq-build.mk
      wget
      which
      xz
      zlib
    ] ++ extraPkgs;
    extraOutputsToInstall = [ "dev" ];
    hardeningDisable = [ "all" ];
    # FAKEROOTDONTTRYCHOWN must be set via extraBwrapArgs (--setenv) so it is
    # present inside the bwrap sandbox itself. Inside Bubblewrap, chown returns
    # EINVAL instead of the EPERM fakeroot expects, which aborts package/install.
    extraBwrapArgs = [ "--setenv" "FAKEROOTDONTTRYCHOWN" "1" ];
  };
in fhs
