{ hostName, ... }:
{
  home.sessionVariables = {
    NIX_CONFIG_HOME = "$HOME/.config/nix-config";
    NIX_HOSTNAME = hostName;

    BACKUP_HOME = "$HOME/Backup";
    BACKUP_NAME = "Current";
    BACKUP_VIEW = "View";
  };
}
