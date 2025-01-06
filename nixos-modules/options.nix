{
  pkgs,
  customLib,
  config,
  ...
}@args:
{
  options.custom = {
    features = customLib.mkOptionsFrom.files ./features { };
  };

  config = customLib.mergeConfigs config.custom.features ./features args;
}
