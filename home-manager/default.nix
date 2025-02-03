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
        has = elem (path + "/scripts") (customLib.getPaths.dirs path);
      in
      if has then
        map (
          path:
          let
            name = customLib.getBaseName path;
          in
          if hasSuffix ".sh" name then
            pkgs.writeShellScriptBin (removeSuffix ".sh" name) (readFile path)
          else if name == "requires.nix" then
            import path pkgs
          else
            throw "Unexpected ${name} file in ${path} directory"
        ) (customLib.getPaths.files (path + "/scripts"))
      else
        [ ]
    ) (filter (path: elem (customLib.getBaseName path) features) (customLib.getPaths.dirs ./features))
  );

  xdg.desktopEntries = customLib.hideDesktopEntries ([ "nixos-manual" ]);
}
