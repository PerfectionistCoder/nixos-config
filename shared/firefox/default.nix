{
  lib,
  pkgs,
  inputs,
  ...
}:
with builtins;
with lib;
let
  generateUserPref =
    file:
    concatStrings (
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
      ) file
    );
in
{
  programs.firefox = {
    enable = true;
    policies = import ./policies.nix;
    profiles.default = {
      isDefault = true;
      bookmarks = import ./bookmarks.nix;
      search = import ./search.nix;
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
      ];
    };
  };
  home.file = {
    ".mozilla/firefox/default/user.js".text =
      readFile (
        pkgs.fetchFromGitHub {
          owner = "yokoffing";
          repo = "Betterfox";
          rev = "09dd87a3abcb15a88798941e5ed74e4aa593108c";
          hash = "sha256-Uu/a5t74GGvMIJP5tptqbiFiA+x2hw98irPdl8ynGoE=";
        }
        + "/user.js"
      )
      + generateUserPref (import ./settings.nix);
  };
}
