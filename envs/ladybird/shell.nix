{
  pkgs,
  extraPkgs ? [],
  ...
}:
pkgs.mkShell {
  name = "ladybird-env";

  inputsFrom = [
    (pkgs.ladybird.override (prev: {
      skia = prev.skia.overrideAttrs (prev: {
        gnFlags = prev.gnFlags ++ [
          "extra_cflags_cc=[\"-frtti\"]"
        ];
      });
    }))
  ];

  packages = with pkgs; [
    ccache
    clang-tools
    nodePackages.prettier

    # Remove once nixpkgs catches up
    libtommath
  ] ++ extraPkgs;

  # https://github.com/NixOS/nixpkgs/blob/79a8a723b9/pkgs/by-name/la/ladybird/package.nix#L144-L147
  NIX_LDFLAGS = "-lGL";
}
