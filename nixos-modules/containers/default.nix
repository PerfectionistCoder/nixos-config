{
  pkgs,
  config,
  lib,
  username,
  customLib,
  home-manager,
  shared,
  ...
}@args:
with builtins;
with lib;
let
  hostCfg = config;
  userUid = hostCfg.users.users."${username}".uid;

  baseCfg = username: {
    config =
      { ... }:
      {
        nixpkgs.pkgs = mkForce pkgs;
        system.stateVersion = hostCfg.system.stateVersion;

        users = {
          mutableUsers = false;
          users = {
            "${username}" = {
              uid = userUid;
              password = "";
              extraGroups = [ "wheel" ];
              isNormalUser = true;
              home = "/home";
            };
          };
        };
      };
  };

  traits = {
    autoLogin = username: {
      config =
        { ... }:
        {
          services.getty.autologinUser = username;
        };
    };
    homeManager = username: {
      config =
        { ... }:
        {
          imports = [ home-manager.nixosModules.home-manager ];

          home-manager = {
            useGlobalPkgs = true;
            users."${username}" = {
              home.stateVersion = hostCfg.system.stateVersion;
            };
          };
        };
    };
    wayland = {
      bindMounts = {
        waylandDisplay = rec {
          hostPath = "/run/user/${toString userUid}";
          mountPoint = hostPath;
        };
      };
      ephemeral = true;

      config =
        { ... }:
        {
          environment.sessionVariables = {
            WAYLAND_DISPLAY = "wayland-1";
            MOZ_ENABLE_WAYLAND = "1";
            XDG_RUNTIME_DIR = "/run/user/${toString userUid}";
            DISPLAY = ":0";
          };
        };
    };
  };

  toContainer = trait: username: if typeOf trait == "lambda" then trait username else trait;
in
{
  options = {
    containers = mkOption {
      apply = str: (_: _) str;
    };
  };
  config = {
    containers = listToAttrs (
      map (
        template:
        let
          name = removeSuffix ".nix" (customLib.getBaseName template);
          username = name + "-user";
          attrset = import ./${customLib.getBaseName template} (args // { inherit hostCfg username; });
          value = mkMerge (
            (map (trait: toContainer trait username) (
              attrValues (filterAttrs (name: _: elem name attrset.traits) traits)
            ))
            ++ [
              attrset.container
              {
                config =
                  { ... }:
                  {
                    home-manager = {
                      users."${username}" = attrset.home-manager;
                    };
                  };
              }
              (baseCfg username)
            ]
          );
        in
        {
          inherit name value;
        }
      ) (customLib.getPaths.excludeDefaultAndDirs ./.)
    );
  };
}
