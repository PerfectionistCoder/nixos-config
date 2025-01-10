{
  pkgs,
  lib,
  customLib,
  config,
  features,
  ...
}@args:
with lib;
{
  options.custom = {
    features = customLib.mkOptionsFrom.files ./features args;

    defaultShellCommand = mkOption {
      type = types.str;
      default = "bash";
    };
  };

  config = customLib.mergeConfigs features ./features args;
}
