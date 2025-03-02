{ ... }:
{
  services.resolved = {
    enable = true;
    dnsovertls = "true";
    extraConfig = ''
      DNS=194.242.2.2#dns.mullvad.net
      Domains=~.
    '';
  };
}
