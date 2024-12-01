{
  config,
  username,
  pkgs,
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

  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ amdvlk ];
  };
}
