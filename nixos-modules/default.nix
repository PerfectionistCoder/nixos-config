{
  pkgs,
  customLib,
  features,
  ...
}@args:
{
  imports = [
    ./self.nix
  ];

  config = customLib.mergeConfigs features ./features args;
}
