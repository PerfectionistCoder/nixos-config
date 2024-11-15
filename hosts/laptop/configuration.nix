{
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
        ];
        useDefaultShell = true;
      };
    };
  };

  boot.loader.timeout = 0;
}
