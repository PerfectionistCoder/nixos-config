{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      nixpkgs,
      home-manager,

      ...
    }@inputs:
    let
      customLib = import ./custom-lib { inherit inputs; };

      nixosModules = ./nixos-modules;

      hostsDir = ./hosts;

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHost =
        params:
        with params;
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit customLib;
            inputs = inputs // {
              nixpkgs-overlays = ./overlays/nixpkgs.nix;
            };
          } // params;
          modules = [
            configPath
            nixosModules
            { nixpkgs.overlays = import ./overlays/nixos.nix; }
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
      packages.${system}.default = pkgs.buildEnv {
        name = "my-env";
        paths = with pkgs; [
          nurl
          nixfmt-rfc-style
          shfmt
          alacritty
          nushell
          carapace
          starship
          chezmoi
          lf
          vscodium
          kickoff
        ];
      };
      nixosConfigurations = genConfiguration hostsDir "configuration";
    };
}
