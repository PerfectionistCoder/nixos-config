{
  pkgs,
  hostCfg,
  username,
  shared,
  ...
}@args:
{
  traits = [
    "autoLogin"
    "homeManager"
    "wayland"
  ];
  container = {
    config = {
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
    };
  };
  home-manager = (shared args).firefox;
}
