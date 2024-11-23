{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wev
    trashy
    nurl
    nixfmt-rfc-style
    shfmt
  ];

  custom = {
    features = {
      firefox.customCss = true;
      bat.customTheme = true;
    };

    defaultShellCommand = "zsh";
  };
}
