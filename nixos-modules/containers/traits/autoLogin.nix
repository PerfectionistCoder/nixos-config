{ username, ... }:
{
  config = {
    services.getty.autologinUser = username;
  };
}
