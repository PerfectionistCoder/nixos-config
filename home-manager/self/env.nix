{ flakeHostname, ... }:
{
  home.sessionVariables = {
    NIX_CONFIG_HOME = "$HOME/.config/nix-config";
    FLAKE_HOSTNAME = flakeHostname;

    BACKUP_HOME = "$HOME/Backup";
    BACKUP_NAME = "Current";
    BACKUP_VIEW = "View";
  };
}
