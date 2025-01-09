{ customLib, ... }@args:
let
  modules = customLib.getPaths.dirs ./.;
in
with builtins;
listToAttrs (
  map (
    path:
    let
      name = customLib.getBaseName path;
    in
    {
      inherit name;
      value = import path args;
    }
  ) modules
)
