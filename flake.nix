{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib.extend (import ./lib);
      inherit (builtins) listToAttrs;
      inherit (lib) genAttrs entryNames;

      eachSystem = genAttrs [ "x86_64-linux" ];

      nixosModules = ./nixos-modules;
      hostsDir = ./hosts;
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
              inputs = inputs // {
                nixpkgs-overlays = ./overlays/default.nix;
              };
            };
            modules = [
              "${hostsDir}/${name}/config.nix"
              nixosModules
              { nixpkgs.overlays = import ./overlays; }
            ];
          };
        }) (entryNames hostsDir)
      );
    };
}
