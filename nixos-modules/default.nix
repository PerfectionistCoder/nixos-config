{
  config,
  customLib,
  features,
  ...
}:
{
  imports = customLib.getPaths.bundleModules ./.;

  custom.features = customLib.enableOptionsFromList (
    customLib.filterSetByList config.custom.features features
  );
}
