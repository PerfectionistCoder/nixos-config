{
  hostCfg,
  username,
  home-manager,
  ...
}:
{
  config = {
    imports = [ home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      users."${username}" = {
        home.stateVersion = hostCfg.system.stateVersion;
      };
    };
  };
}
