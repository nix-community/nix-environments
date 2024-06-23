{
  # Unstable is required as stable does not contain required glib
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixpkgs-unstable.tar.gz"; # TODO: Remove unstable override, when we have 24.11
  }) { }
, extraPkgs ? []
}:
let
  # POSIX compliant gcc wrappers for backwards compatiblity
  # https://gitlab.archlinux.org/archlinux/packaging/packages/gcc/-/commit/cacf18c7cd79fb00645a4bf367392b05ad2dc290
  # Small change: last line was '${1+"$@"}' which throws causes nix
  # to throw an error: add not allowed for integer and string
  c98 = pkgs.writeShellScriptBin "c98" ''
    set -eu -o pipefail
    fl="-std=c89"
    for opt; do
      case "$opt" in
        -ansi|-std=c89|-std=iso9899:1990) fl="";;
        -std=*) echo "`basename $0` called with non ANSI/ISO C option $opt" >&2
          exit 1;;
      esac
    done
    exec gcc $fl "$@"
  '';
  c99 = pkgs.writeShellScriptBin "c99" ''
    set -eu -o pipefail
    fl="-std=c99"
    for opt; do
      case "$opt" in
        -std=c99|-std=iso9899:1999) fl="";;
        -std=*) echo "`basename $0` called with non ISO C99 option $opt" >&2
          exit 1;;
      esac
    done
    exec gcc $fl "$@"
  '';
in
  # Unfortunately the more versatile and nix-nativ mkShell does not work
  # for buildroot as some of the paths are hardcoded and expect a usual
  # linux posix-compliant file system structure
  (pkgs.buildFHSUserEnv {
    name = "buildroot";
    targetPkgs = pkgs: (with pkgs; [
      (lib.hiPrio gcc)
      bashInteractive
      bc
      binutils
      bzip2
      c98
      c99
      ccache # optional, speeds up consecutive builds
      cmake
      cpio
      diffutils
      expat # not mentioned in buildroot deps; dep of host-libxml-parser-perl
      expect # not mentioned in buildroot deps
      file
      findutils
      gcc
      glib # not mentioned; not sure if necessary
      glibc # transitively mentioned: debian build-essential
      gnumake
      gnused
      gnutar
      gzip
      libxcrypt # not mentioned in buildroot deps; required for host-mkpasswd
      ncurses # optional
      patch
      perl
      pkg-config # not mentioned, unsure if necessary
      rsync
      unzip
      wget
      which
    ] ++ pkgs.linux.nativeBuildInputs ++ extraPkgs);
    runScript = ''
      # The host-uboot-tools package uses objcopy from the shells OBJCOPY var
      # Since the var is set to OBJCOPY=objcopy the buildroot provided 
      # CROSS_COMPILE path is ignored hence the script is using the wrong objcopy
      unset $OBJCOPY
      exec bash
    '';
  }).env
