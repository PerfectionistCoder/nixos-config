{ flakeHostname, username, ... }:
{
  home.stateVersion = "24.05";

  # home.enableNixpkgsReleaseCheck = false;
  news.display = "silent";

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.sessionVariables = {
    NIXOS_CONFIG_HOME = "$HOME/.config/nixos-config";
    FLAKE_HOSTNAME = flakeHostname;
  };

  programs.bash = {
    enable = true;
    historyFileSize = 0;
    profileExtra = ''
      if [[ $(tty) == /dev/tty1 ]]; then
        exec Hyprland
      fi
    '';
  };
}
