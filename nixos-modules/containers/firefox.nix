{ hostCfg, username, ... }:
{
  traits = [
    "defaultUser"
    "homeManager"
    "wayland"
  ];
  container = {
    config =
      { pkgs, ... }:
      {
        hardware.graphics = {
          enable = true;
          extraPackages = hostCfg.hardware.graphics.extraPackages;
        };

        services.pipewire.enable = true;

        fonts = {
          packages = with pkgs; [
            (ibm-plex.override { families = [ "sans" ]; })
            noto-fonts-cjk-sans
            noto-fonts-cjk-serif
          ];
          fontconfig = {
            defaultFonts = {
              sansSerif = [
                "IBM Plex Sans"
                "Noto Sans CJK HK"
              ];
              serif = [ "Noto Serif CJK HK" ];
            };
          };
        };

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
