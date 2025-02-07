{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nurl
    nixfmt-rfc-style
    shfmt
    alacritty
    nushell
    carapace
    starship
    chezmoi
    rclone
    age
  ];
}
