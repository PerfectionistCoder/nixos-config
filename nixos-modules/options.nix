{
  pkgs,
  customLib,
  config,
  ...
}@args:
with customLib;
{
  options.custom = {
    features = mkOptionsFrom.files ./features { };
  };

  config = mergeConfigs config.custom.features ./features args;
}
