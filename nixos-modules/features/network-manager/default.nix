{ config, ... }:
{
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = config.services.resolved.enable or false;
}
