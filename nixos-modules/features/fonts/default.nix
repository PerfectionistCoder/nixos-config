{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      (ibm-plex.override { families = [ "sans" ]; })
      cascadia-code
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "IBM Plex Sans"
        ];
        monospace = [
          "Cascadia Mono NF"
        ];
      };
    };
  };
}
