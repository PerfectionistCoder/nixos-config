{ hostCfg, username, ... }:
{
  traits = [
    "defaultUser"
    "homeManager"
    "wayland"
  ];
  container = {
    config =
      { ... }:
      {
        hardware.graphics = {
          enable = true;
          extraPackages = hostCfg.hardware.graphics.extraPackages;
        };

        services.pipewire.enable = true;

        home-manager = {
          users."${username}" = {
            programs.firefox = {
              enable = true;
            };
          };
        };
      };
  };
}
