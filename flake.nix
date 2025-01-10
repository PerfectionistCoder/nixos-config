{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      home-manager-unstable,
      rust-overlay,
      ...
    }@inputs:
    let
      customLib = import ./custom-lib { inherit inputs; };
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    with builtins;
    forAllSystems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import rust-overlay)
          ];
        };
      in
      {
        formatter = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
        devShells = {
          rust = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              (rust-bin.stable.latest.default.override {
                extensions = [
                  "rust-src"
                  "cargo"
                  "rustc"
                ];
              })
              gcc
            ];

            RUST_SRC_PATH = "${
              pkgs.rust-bin.stable.latest.default.override {
                extensions = [ "rust-src" ];
              }
            }/lib/rustlib/src/rust/library";

            buildInputs = with pkgs; [
              clippy
            ];
            shellHook = ''
              PATH+=":/home/desktop/.cargo/bin"

              cd ~/Code/rust

              codium --profile Rust .
            '';
          };
        };
      }
    )
    // (
      let
        nixosModules = ./nixos-modules;
        homeManagerModules = ./home-manager;
        sharedModules = import ./shared;

        hostsDir = ./hosts;

        mkHost =
          params:
          with params;
          (if stable then nixpkgs else nixpkgs-unstable).lib.nixosSystem {
            specialArgs = {
              inherit inputs customLib;
              home-manager = if stable then home-manager else home-manager-unstable;
              shared = sharedModules;
            } // params;
            modules = [
              configPath
              nixosModules
            ];
          };
        mkHomeManager =
          params:
          with params;
          (if stable then home-manager else home-manager-unstable).lib.homeManagerConfiguration {
            pkgs = customLib.getPkgs system stable;
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
