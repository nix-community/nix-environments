{
  description = "Nix environments";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    in {
      devShells = nixpkgs.lib.genAttrs systems (system: import ./. {
        pkgs = import nixpkgs { inherit system; };
        pkgsUnfree = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      });
    };
}
