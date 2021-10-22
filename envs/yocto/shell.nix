{ pkgs ? import <nixpkgs> {} }:

let
  fhs = pkgs.buildFHSUserEnvBubblewrap {
    name = "yocto-fhs";
    targetPkgs = pkgs: (with pkgs; [
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
        lzma
        ncurses
        patch
        perl
        python3
        rpcsvc-proto
        unzip
        util-linux
        wget
        which
      ]);
    multiPkgs = null;
    extraOutputsToInstall = [ "dev" ];
    profile =
      let
        wrapperEnvar = "NIX_CC_WRAPPER_TARGET_HOST_${pkgs.stdenv.cc.suffixSalt}";
        # TODO limit export to native pkgs?
        nixconf = pkgs.writeText "nixvars.conf" ''
          # This exports the variables to actual build environments
          # From BB_ENV_EXTRAWHITE
          export LOCALE_ARCHIVE
          export ${wrapperEnvar}
          export NIX_DONT_SET_RPATH = "1"

          # Exclude these when hashing
          # the packages in yocto
          BB_HASHBASE_WHITELIST += " LOCALE_ARCHIVE \
                                    NIX_DONT_SET_RPATH \
                                    ${wrapperEnvar} "
        '';
      in
      ''
        # These are set by buildFHSUserEnvBubblewrap
        export BB_ENV_EXTRAWHITE=" LOCALE_ARCHIVE \
                                  ${wrapperEnvar} \
                                  $BB_ENV_EXTRAWHITE "

        # source the config for bibake equal to --postread
        export BBPOSTCONF="${nixconf}"
      '';
  };
in fhs.env
