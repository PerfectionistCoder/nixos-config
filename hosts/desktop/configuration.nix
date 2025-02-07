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

  hardware = {
    graphics.enable = true;
    amdgpu.initrd.enable = true;
  };
}
