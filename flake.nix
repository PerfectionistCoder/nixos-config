{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-overlays = {
      url = "path:./overlays/nixpkgs.nix";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,

      ...
    }@inputs:
    let
      lib = nixpkgs.lib.extend (import ./lib);
      inherit (builtins) listToAttrs;
      inherit (lib) genAttrs entryNames;

      nixosModules = ./nixos-modules;
      hostsDir = ./hosts;

      eachSystem = genAttrs [ "x86_64-linux" ];
    in
    {
      packages = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.buildEnv {
            name = "nix-packages";
            paths = import ./packages pkgs;
          };
        }
      );
      nixosConfigurations = listToAttrs (
        map (name: {
          inherit name;
          value = nixpkgs.lib.nixosSystem {
            inherit lib;
            specialArgs = {
              inherit inputs;
            };
            modules = [
              "${hostsDir}/${name}/config.nix"
              nixosModules
              { nixpkgs.overlays = import ./overlays/nixos.nix; }
            ];
          };
        }) (entryNames hostsDir)
      );
    };
}
