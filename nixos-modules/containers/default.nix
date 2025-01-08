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
with lib;
let
  hostCfg = config;
  userUid = hostCfg.users.users."${username}".uid;

  traits = username: {
    base = {
      config =
        { ... }:
        {
          nixpkgs.pkgs = mkForce pkgs;
          system.stateVersion = hostCfg.system.stateVersion;
        };
    };
    defaultUser = {
      config =
        { ... }:
        {
          services.getty.autologinUser = username;
          users = {
            mutableUsers = false;
            users = {
              root.password = "";
              "${username}" = {
                uid = userUid;
                password = "";
                isNormalUser = true;
                home = "/home";
              };
            };
          };
        };
    };
    homeManager = {
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
in
{
  containers = listToAttrs (
    map (
      template:
      let
        name = removeSuffix ".nix" (customLib.getBaseName template);
        username = name + "-user";
        attrset = import ./${customLib.getBaseName template} (args // { inherit hostCfg username; });
      in
      {
        inherit name;
        value = mkMerge ((attrValues (traits username)) ++ [ attrset.container ]);
      }
    ) (customLib.getPaths.excludeDefaultAndDirs ./.)
  );
}
