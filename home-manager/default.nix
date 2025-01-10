{
  pkgs,
  lib,
  customLib,
  config,
  features,
  ...
}@args:
with lib;
{
  imports = [
    ./self.nix
    ./options.nix
    ./theme
  ];

  home.packages = flatten (
    map (
      path:
      let
        name = customLib.getBaseName path;
      in
      if (elem name features) then
        (map (
          subPath:
          let
            name = customLib.getBaseName subPath;
          in
          if hasSuffix ".sh" name then
            pkgs.writeShellScriptBin (removeSuffix ".sh" name) (readFile subPath)
          else if name == "requires.nix" then
            import subPath pkgs
          else
            throw "Unexpected ${name} file in ${path} directory"
        ) (customLib.getPaths.recursive path))
      else
        [ ]
    ) (customLib.getPaths.dirs ./scripts)
  );

  xdg = {
    desktopEntries = { } // (customLib.hideDesktopEntries ([ "nixos-manual" ]));
  };
}
