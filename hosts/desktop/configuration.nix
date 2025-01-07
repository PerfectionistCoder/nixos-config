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

  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    tmp = {
      useTmpfs = true;
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ amdvlk ];
  };
}
