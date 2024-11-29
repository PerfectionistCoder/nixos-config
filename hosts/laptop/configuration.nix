{
  lib,
  config,
  username,
  ...
}:
{
  users = {
    users = {
      "${username}" = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
        ];
        useDefaultShell = true;
      };
    };
  };

  boot.loader.timeout = 0;

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    enableOnBoot = false;
  };
  systemd.sockets.docker.wantedBy = lib.mkForce [ ];
}
