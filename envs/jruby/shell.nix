{ pkgs ? import <nixpkgs> { } }:
with pkgs;
with stdenv;
with stdenv.lib;
mkShell {
  name = "jruby-shell";

  buildInputs = [ jruby cacert ];

  # Likely want a CA file; so lets add one.
  SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";

  # Make UTF8 the default as it's more sane
  LANG = "en_US.UTF-8";
  shellHook = ''
      # https://nixos.org/nixpkgs/manual/#locales
      export optionalString isLinux LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
      # JRuby wants to install Gem's in the nix-store which is read-only
      # set GEM_HOME to make it a writable directory
    	export GEM_HOME=$(${jruby}/bin/ruby -e 'puts Gem.user_dir')
      export GEM_PATH=$GEM_HOME
      # Add the GEM binary files to the path
      export PATH=$GEM_HOME/bin:$PATH
      '';
}
