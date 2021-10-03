{
  description = "Nix environments";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = f: nixpkgs.lib.genAttrs
        [ "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ]
        (system: f system);
      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
        }
      );
    in
    {

      devShells = forAllSystems
        (system:
          let
            pkgs = nixpkgsFor.${system};
          in
          {
            arduino = import ./envs/arduino/shell.nix { inherit pkgs; };
            github-pages = import ./envs/github-pages/shell.nix { inherit pkgs; };
            home-assistant = import ./envs/home-assistant/shell.nix { inherit pkgs; };
            nannou = import ./envs/nannou/shell.nix { inherit pkgs; };
            jruby = import ./envs/jruby/shell.nix { inherit pkgs; };
            openwrt = import ./envs/openwrt/shell.nix { inherit pkgs; };
            phoronix-test-suite = import ./envs/phoronix-test-suite/shell.nix { inherit pkgs; };
            spec-benchmark = import ./envs/spec-benchmark/shell.nix { inherit pkgs; };
          });

    };
}
