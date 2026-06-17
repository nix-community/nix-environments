{
  pkgs,
  extraPkgs ? [],
  ...
}:
pkgs.mkShell {
  name = "ladybird-env";

  inputsFrom = [
    pkgs.ladybird
  ];

  packages = with pkgs; [
    ccache
    clang-tools
    prettier
    icu78.dev
    mimalloc
    dejavu_fonts
    liberation_ttf
  ] ++ extraPkgs;

  ICU_ROOT = "${pkgs.icu78.dev}";

  FONTCONFIG_FILE = pkgs.makeFontsConf {
    fontDirectories = [ pkgs.dejavu_fonts pkgs.liberation_ttf ];
  };

  # https://github.com/NixOS/nixpkgs/blob/79a8a723b9/pkgs/by-name/la/ladybird/package.nix#L144-L147
  NIX_LDFLAGS = "-lGL -lfontconfig";
}
