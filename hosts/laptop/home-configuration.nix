{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    gnome.file-roller
    microsoft-edge
    keepassxc
    libreoffice
    hunspell
    hunspellDicts.en_GB-ize
    evince
    nixfmt-rfc-style
    ungoogled-chromium
  ];

  custom.defaultShellCommand = "zsh";
}
