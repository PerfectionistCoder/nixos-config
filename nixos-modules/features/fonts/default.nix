{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      selfDefinePkgs.fonts.monospace
    ];
  };
}
