{ pkgs, ... }:
{
  imports = [ /etc/nixos/hardware-configuration.nix ];

  system.stateVersion = "24.11";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
      tmpfsSize = "50%";
    };
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 1d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  systemd.services.NetowrkManager-wait-online.enable = false;

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
