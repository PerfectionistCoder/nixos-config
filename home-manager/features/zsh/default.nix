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

      plugins = map (plugin: {
        name = plugin.name or plugin.src.pname;
        src = plugin.src or pkgs.${plugin.name};
        file = plugin.file or "share/${plugin.name}/${plugin.name}.zsh";
      }) plugins;
    };

  home.file.".zsh/completions".source = ./completions;
}
