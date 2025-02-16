{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix.url = "github:numtide/treefmt-nix";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
  };

  outputs =
    {
      systems,
      nixpkgs,
      home-manager,
      treefmt-nix,
      ...
    }@inputs:
    let
      customLib = import ./custom-lib { inherit inputs; };
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    with builtins;
    {
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
    }
    // (
      let
        nixosModules = ./nixos-modules;
        homeManagerModules = ./home-manager;
        sharedModules = import ./shared;

        hostsDir = ./hosts;

        mkHost =
          params:
          with params;
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs customLib;
            } // params;
            modules = [
              configPath
              nixosModules
            ];
          };
        mkHomeManager =
          params:
          with params;
          home-manager.lib.homeManagerConfiguration {
            pkgs = customLib.getPkgs system;
            extraSpecialArgs = {
              inherit inputs customLib flakeHostname;
              shared = sharedModules;
            } // params;
            modules = [
              configPath
              homeManagerModules
            ];
          };
        genConfiguration =
          path: type:
          assert builtins.match "home-configuration|configuration" type != null;
          builtins.listToAttrs (
            map (
              hostPath:
              let
                flakeHostname = customLib.getBaseName hostPath;
                value = (if type == "home-configuration" then mkHomeManager else mkHost) (
                  {
                    inherit flakeHostname;
                    configPath = hostPath + "/${type}.nix";
                  }
                  // import (hostPath + "/params.nix")
                );
              in
              {
                inherit value;
                name = flakeHostname;
              }
            ) (customLib.getPaths.dirs path)
          );
      in
      {
        nixosConfigurations = genConfiguration hostsDir "configuration";
        homeConfigurations = genConfiguration hostsDir "home-configuration";
      }
    );
}
