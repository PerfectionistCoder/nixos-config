{ pkgs, ... }@args:
{
  imports = [ /etc/nixos/hardware-configuration.nix ];

  system.stateVersion = (import /etc/nixos/configuration.nix args).system.stateVersion;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  time.timeZone = "Europe/London";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  services.pipewire.enable = true;

  environment.systemPackages = with pkgs; [
    git
    home-manager
  ];
}
