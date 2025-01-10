{
  pkgs,
  lib,
  hostCfg,
  userUid,
  username,
  ...
}:
with lib;
{
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
}
