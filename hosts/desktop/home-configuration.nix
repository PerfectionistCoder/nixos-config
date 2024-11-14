{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wev
    trashy
    nurl
    nixfmt-rfc-style
  ];

  custom = {
    features = {
      firefox.customCss = true;
      bat.customTheme = true;
    };

    defaultShellCommand = "zsh";
  };
}
