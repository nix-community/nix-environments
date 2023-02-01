{ pkgs ? import <nixpkgs> {}
, extraPkgs ? []
}:

let
  fhs = pkgs.buildFHSUserEnvBubblewrap {
    name = "yocto-fhs";
    targetPkgs = pkgs: (with pkgs; [
        attr
        bc
        binutils
        bzip2
        chrpath
        cpio
        diffstat
        expect
        file
        gcc
        gdb
        git
        gnumake
        hostname
        kconfig-frontends
        libxcrypt
        lz4
        ncurses
        patch
        perl
        python3
        rpcsvc-proto
        unzip
        util-linux
        wget
        which
        xz
        zlib
        zstd
      ] ++ extraPkgs);
    multiPkgs = null;
    extraOutputsToInstall = [ "dev" ];
    profile =
      let
        inherit (pkgs) lib;

        setVars = {
          "NIX_DONT_SET_RPATH" = "1";
        };

        exportVars = [
          "LOCALE_ARCHIVE"
          "NIX_CC_WRAPPER_TARGET_HOST_${pkgs.stdenv.cc.suffixSalt}"
          "NIX_CFLAGS_COMPILE"
          "NIX_CFLAGS_LINK"
          "NIX_LDFLAGS"
          "NIX_DYNAMIC_LINKER_${pkgs.stdenv.cc.suffixSalt}"
        ];

        exports =
          (builtins.attrValues (builtins.mapAttrs (n: v: "export ${n}= \"${v}\"") setVars)) ++
          (builtins.map (v: "export ${v}") exportVars);

        passthroughVars = (builtins.attrNames setVars) ++ exportVars;

        # TODO limit export to native pkgs?
        nixconf = pkgs.writeText "nixvars.conf" ''
          # This exports the variables to actual build environments
          # From BB_ENV_PASSTHROUGH_ADDITIONS
          ${lib.strings.concatStringsSep "\n" exports}

          # Exclude these when hashing
          # the packages in yocto
          BB_BASEHASH_IGNORE_VARS += "${lib.strings.concatStringsSep " " passthroughVars}"
        '';
      in
      ''
        # buildFHSUserEnvBubblewrap configures ld.so.conf while buildFHSUserEnv additionally sets the LD_LIBRARY_PATH.
        # This is redundant, and incorrectly overrides the RPATH of yocto-built binaries causing the dynamic loader
        # to load libraries from the host system that they were not built against, instead of those from yocto.
        unset LD_LIBRARY_PATH

        # By default gcc-wrapper will compile executables that specify a dynamic loader that will ignore the FHS
        # ld-config causing unexpected libraries to be loaded when when the executable is run.
        export NIX_DYNAMIC_LINKER_${pkgs.stdenv.cc.suffixSalt}="/lib/ld-linux-x86-64.so.2"

        # These are set by buildFHSUserEnvBubblewrap
        export BB_ENV_PASSTHROUGH_ADDITIONS="${lib.strings.concatStringsSep " " passthroughVars}"

        # source the config for bibake equal to --postread
        export BBPOSTCONF="${nixconf}"
      '';
  };
in fhs.env
