{ ... }:
let
  username = "user";
in
{
  users = {
    users = {
      ${username} = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
          "machine"
        ];
      };
    };
  };
  services.getty.autologinUser = username;

  features = {
    extra-container.enable = true;
    fonts.enable = true;
    graphics.enable = true;
    river.enable = true;
  };
}
