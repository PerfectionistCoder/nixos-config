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
}
