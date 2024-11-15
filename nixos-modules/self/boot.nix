{ lib, ... }:
{
  boot.loader = {
    systemd-boot = {
      configurationLimit = 3;
    };
    timeout = lib.mkDefault 3;
  };
}
