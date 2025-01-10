{
  config,
  customLib,
  features,
  ...
}:
{
  imports = [
    ./self.nix
    ./options.nix
    ./containers
  ];

  custom.features = customLib.enableOptionsFromList (
    customLib.filterSetByList config.custom.features features
  );
}
