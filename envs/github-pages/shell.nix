with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "env";

  buildInputs = [
    libxslt
    ruby
    bashInteractive
    zlib
    pkgconfig
    libxml2
    bundler
  ];
}
