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
    defaultShellCommand = "zsh";
  };
}
