{
  pkgs,
  lib,
  customLib,
  config,
  ...
}@args:
with customLib;
with lib;
{
  options.custom = {
    features = mkOptionsFrom.files ./features args;
    scripts = mkOptionsFrom.files ./scripts { };

    defaultShellCommand = mkOption {
      type = types.str;
      default = "bash";
    };
  };

  config = mergeConfigs config.custom.features ./features args;
}
