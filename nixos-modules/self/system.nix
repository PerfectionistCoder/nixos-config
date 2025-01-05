{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixVersions.stable;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    home-manager
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  systemd.services.NetowrkManager-wait-online.enable = false;

  security.rtkit.enable = true;
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  services.udisks2.enable = true;
}
