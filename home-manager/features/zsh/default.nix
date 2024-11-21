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
      pkgsList = [
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        {
          name = "zsh-fzf-tab";
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
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
        append = true;
        share = true;
        ignoreSpace = true;
        ignoreAllDups = true;
      };
      completionInit = import ./completion.nix config lib;
      initExtra = import ./config.nix lib config + import ./keybinds.nix lib;
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
          nmOrAttr
          // {
            name = nmOrAttr.name or nmOrAttr.src.pname;
            src = nmOrAttr.src or pkgs.${nmOrAttr.name};
          }
        else
          throw "Unaccepted zsh plugin package format"
      ) pkgsList;
    };

  home.file.".zsh/completions".source = ./_funcs;
}
