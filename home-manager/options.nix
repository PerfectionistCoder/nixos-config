{
  pkgs,
  lib,
  customLib,
  config,
  ...
}@args:
with lib;
{
  options.custom = {
    features = customLib.mkOptionsFrom.files ./features args;
    scripts = customLib.mkOptionsFrom.files ./scripts { };

    defaultShellCommand = mkOption {
      type = types.str;
      default = "bash";
    };
  };

  config = customLib.mergeConfigs config.custom.features ./features args;
}
