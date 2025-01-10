{
  pkgs,
  username,
  ...
}:
{
  users = {
    users = {
      "${username}" = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        useDefaultShell = true;
      };
    };
  };

  hardware.amdgpu = {
    initrd.enable = true;
    amdvlk.enable = true;
  };
}
