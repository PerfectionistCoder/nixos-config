{
  username = "laptop";
  system = "x86_64-linux";
  stable = true;

  features = [
    "dconf"
    "firefox"
    "fzf"
    "gnome-terminal"
    "gpg"
    "starship"
    "vscodium"
    "zsh"

    "rclone"

    "gnome"
    "ssh"
  ];
}
