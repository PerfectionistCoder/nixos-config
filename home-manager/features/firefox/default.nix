{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with builtins;
with lib;
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      bookmarks = import ./bookmarks.nix;
      search = import ./search.nix;
    };
  };
  home.file = {
    ".mozilla/firefox/default/user.js".text =
      readFile (
        pkgs.fetchFromGitHub {
          owner = "yokoffing";
          repo = "Betterfox";
          rev = "429abb61f52726b7c6f1675bccca32bbb5359c02";
          hash = "sha256-CxPZxo9G44lRocNngjfwTBHSqL5dEJ5MNO5Iauoxp2Y=";
        }
        + "/user.js"
      )
      + (concatStrings (
        mapAttrsToList (
          name: value:
          "\nuser_pref(\"${name}\", ${
            let
              type = typeOf value;
            in
            if type == "int" then
              toString value
            else if type == "bool" then
              boolToString value
            else
              "\"${value}\""
          });"
        ) (import ./settings.nix lib config)
      ));
  };
}
