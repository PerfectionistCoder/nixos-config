{
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

  services.getty.autologinUser = username;

  hardware = {
    graphics.enable = true;
    amdgpu.initrd.enable = true;
  };
}
