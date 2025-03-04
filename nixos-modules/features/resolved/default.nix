{ ... }:
{
  networking = {
    networkmanager.dns = "systemd-resolved";
    nameservers = [
      "194.242.2.2#dns.mullvad.net"
    ];
  };

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    dnsovertls = "true";
  };
}
