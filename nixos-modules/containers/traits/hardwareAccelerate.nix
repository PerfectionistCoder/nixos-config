{ hostCfg, ... }:
{
  config = {
    hardware.graphics = {
      enable = true;
      extraPackages = hostCfg.hardware.graphics.extraPackages;
    };
  };
}
