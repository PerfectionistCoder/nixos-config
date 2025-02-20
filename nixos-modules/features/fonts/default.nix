{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      # nerd-fonts.caskaydia-mono
      (nerdfonts.override { fonts = [ "CascadiaMono" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [
          "CaskaydiaMono NF"
        ];
      };
    };
  };
}
