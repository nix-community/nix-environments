{
  pkgs ? import <nixpkgs> { },
  extraPkgs ? [ ],
}:

with pkgs;
mkShell {
  nativeBuildInputs = [
    # Building git
    libiconv

    # Building the docs
    asciidoc
    docbook-xsl-nons
    docbook_xml_dtd_45
    libxslt
    xmlto
  ];
  buildInputs =
    [
      curl
      expat
      gettext
      openssl
      perl
      zlib
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreServices
    ]
    ++ extraPkgs;
  PERL_PATH = "${perl.outPath}/bin/perl";
  shellHook = lib.strings.optionalString stdenv.isDarwin ''
    export NIX_LDFLAGS="-F${darwin.apple_sdk.frameworks.CoreServices}/Library/Frameworks -framework CoreServices $NIX_LDFLAGS"
  '';
}
