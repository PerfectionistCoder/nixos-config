{
  pkgs,
  lib,
  customLib,
  config,
  features,
  ...
}:
with lib;
{
  imports = customLib.getPaths.bundleModules ./. ++ [ ./theme ];

  home.packages = flatten (
    map (
      path:
      let
        name = customLib.getBaseName path;
      in
      if config.custom.scripts.${name}.enable then
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

  custom = {
    features = customLib.enableOptionsFromList (
      customLib.filterSetByList config.custom.features features
    );
    scripts = customLib.enableOptionsFromList (
      (customLib.filterSetByList config.custom.scripts features) ++ [ "common" ]
    );
  };

  xdg = {
    desktopEntries = { } // (customLib.hideDesktopEntries ([ "nixos-manual" ]));
  };
}
