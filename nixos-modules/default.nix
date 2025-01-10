{
  config,
  customLib,
  features,
  ...
}:
{
  imports = [
    ./base.nix
    ./options.nix
    ./containers
  ];

  custom.features = customLib.enableOptionsFromList (
    customLib.filterSetByList config.custom.features features
  );
}
