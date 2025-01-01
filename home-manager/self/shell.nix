{ ... }:
{
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
