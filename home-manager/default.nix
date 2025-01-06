{
  pkgs,
  lib,
  customLib,
  config,
  features,
  ...
}:
with customLib;
with lib;
{
  imports = getPaths.bundleModules ./. ++ [ ./theme ];

  home.packages = flatten (
    map (
      path:
      let
        name = getBaseName path;
      in
      if config.custom.scripts.${name}.enable then
        (map (
          subPath:
          let
            name = getBaseName subPath;
          in
          if hasSuffix ".sh" name then
            pkgs.writeShellScriptBin (removeSuffix ".sh" name) (readFile subPath)
          else if name == "requires.nix" then
            import subPath pkgs
          else
            throw "Unexpected ${name} file in ${path} directory"
        ) (getPaths.recursive path))
      else
        [ ]
    ) (getPaths.dirs ./scripts)
  );

  custom = {
    features = enableOptions (filterNonExistingOption config.custom.features features);
    scripts = enableOptions ((filterNonExistingOption config.custom.scripts features) ++ [ "common" ]);
  };

  xdg = {
    desktopEntries = { } // (with config.custom.features; hideDesktopEntries ([ "nixos-manual" ]));
  };
}
