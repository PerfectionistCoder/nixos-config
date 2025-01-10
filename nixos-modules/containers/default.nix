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

  traits = listToAttrs (
    map (
      path:
      let
        fileName = customLib.getBaseName path;
        name = removeSuffix ".nix" fileName;
        value = import path;
      in
      {
        inherit name value;
      }
    ) (customLib.getPaths.all ./traits)
  );
in
{
  containers = listToAttrs (
    map (
      path:
      let
        fileName = customLib.getBaseName path;
        name = removeSuffix ".nix" fileName;
        username = name + "-user";
        allArgs = args // {
          inherit hostCfg username userUid;
        };
        attrset = import path allArgs;
        value = mkMerge (
          (map (trait: trait allArgs) (
            attrValues (filterAttrs (name: _: name == "base" || elem name attrset.traits) traits)
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
          ]
        );
      in
      {
        inherit name value;
      }
    ) (customLib.getPaths.excludeDefaultAndDirs ./.)
  );

}
