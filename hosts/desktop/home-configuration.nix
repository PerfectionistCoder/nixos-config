{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nurl
    nixfmt-rfc-style
    shfmt
  ];
}
