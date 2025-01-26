{
  pkgs,
  customLib,
  features,
  ...
}@args:
{
  imports = [
    ./self.nix
    # ./containers
  ];

  config = customLib.mergeConfigs features ./features args;
}
