{ flakeHostname, ... }:
{
  home.sessionVariables = {
    NIXOS_CONFIG_HOME = "$HOME/.config/nixos-config";
    FLAKE_HOSTNAME = flakeHostname;

    BACKUP_HOME = "$HOME/Backup";
    BACKUP_NAME = "Current";
    BACKUP_VIEW = "View";
  };
}
