{
  pkgs,
  lib,
  config,
  ...
}:
with builtins;
with lib;
{
  programs.zsh =
    let
      plugins = import ./plugins.nix config lib;
    in
    {
      enable = true;
      dotDir = ".zsh";
      history = rec {
        size = 1000;
        save = size;
        path = "$ZDOTDIR/.zsh_history";
        ignorePatterns = [
          "gen-passwd*"
          "get-passwd*"
          "gpg *"
          "pass *"
          ""
        ];
        share = true;
        ignoreSpace = true;
        ignoreAllDups = true;
      };
      completionInit = import ./completion.nix;
      initExtra =
        import ./config.nix lib config
        + import ./keybinds.nix lib
        + (concatStringsSep "" (map (plugin: "\n" + plugin.config) plugins));
      shellAliases = import ./aliases.nix;

      plugins = map (
        nmOrAttr:
        let
          type = typeOf nmOrAttr;
        in
        if type == "string" then
          {
            name = nmOrAttr;
            src = pkgs.${nmOrAttr};
            file = "share/${nmOrAttr}/${nmOrAttr}.zsh";
          }
        else if type == "set" then
          filterAttrs (
            name: _:
            elem name [
              "name"
              "src"
              "file"
            ]
          ) nmOrAttr
          // {
            name = nmOrAttr.name or nmOrAttr.src.pname;
            src = nmOrAttr.src or pkgs.${nmOrAttr.name};
          }
        else
          throw "Unaccepted zsh plugin package format"
      ) plugins;
    };

  home.file.".zsh/completions".source = ./completions;
}
