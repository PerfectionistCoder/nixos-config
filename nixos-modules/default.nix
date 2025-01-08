{
  config,
  customLib,
  features,
  ...
}:
{
  imports = customLib.getPaths.bundleModules ./. ++ [ ./containers ];

  custom.features = customLib.enableOptionsFromList (
    customLib.filterSetByList config.custom.features features
  );
}
