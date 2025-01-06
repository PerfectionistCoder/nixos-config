{ inputs }:
with inputs.nixpkgs.lib;
with builtins;
rec {
  getPkgs =
    system: stable:
    import inputs.${if stable then "nixpkgs" else "nixpkgs-unstable"} { inherit system; };

  getPaths =
    let
      readDirFilter =
        path: lambda: (map (name: path + "/${name}") (attrNames (filterAttrs lambda (readDir path))));
    in
    rec {
      all = path: readDirFilter path (_: _: true);

      files = path: readDirFilter path (_: value: value == "regualr");

      dirs = path: readDirFilter path (_: value: value == "directory");

      excludeDefaultAndDirs =
        path: readDirFilter path (name: value: name != "default.nix" && value != "directory");

      recursive =
        path:
        flatten (
          attrValues (
            mapAttrs (
              name: value: if value == "directory" then recursive (path + "/${name}") else "${path}/${name}"
            ) (readDir path)
          )
        );

      bundleModules = path: (excludeDefaultAndDirs path) ++ (all (path + "/self"));
    };

  getBaseName = path: last (splitString "/" (toString path));

  mkOptionsFrom = {
    set =
      set:
      mapAttrs (
        name: value:
        let
          type = typeOf value;
        in
        if type == "string" then
          mkOption { type = types.str; }
        else if type == "list" then
          mkOption { type = with types; listOf str; }
        else
          mkOption { type = types.${typeOf value}; }
      ) set;

    files =
      path: args:
      mapAttrs (
        name: _:
        (
          {
            enable = mkEnableOption "";
          }
          // (if args != { } then (import (path + "/${name}") args).options or { } else { })
        )
      ) (readDir path);
  };
  
  enableOptions =
    list:
    listToAttrs (
      map (option: {
        name = option;
        value = {
          enable = mkDefault true;
        };
      }) list
    );

  filterNonExistingOption =
    options: list: intersectLists (mapAttrsToList (name: _: name) options) list;

  mergeConfigs =
    options: path: args:
    mkMerge (
      map (
        option:
        let
          module = (import option) args;
          imports = map (subModule: (import subModule) args) (module.imports or [ ]);
          config = mkMerge (
            [ (filterAttrs (name: _: name != "imports" && name != "options") module) ] ++ imports
          );
        in
        mkIf (options.${getBaseName option}.enable) config
      ) (getPaths.dirs path)
    );

  hideDesktopEntries =
    entries:
    listToAttrs (
      map (opt: {
        name = opt;
        value = {
          name = "";
          noDisplay = true;
        };
      }) entries
    );
}
