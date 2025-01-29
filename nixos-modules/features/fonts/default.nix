{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.caskaydia-mono
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ ];
        monospace = [
          "CaskaydiaMono NF"
        ];
      };
    };
  };
}
