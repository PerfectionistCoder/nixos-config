final: prev:
let
  inherit (builtins) attrNames readDir;
  inherit (final)
    mkIf
    mkEnableOption
    entryNames
    entryPaths
    wrapMkOption
    ;
in
{
  entryNames = path: attrNames (readDir path);
  entryPaths = path: map (name: path + "/${name}") (entryNames path);
  wrapMkOption = config: module: name: {
    options = {
      features.${name} = module.options or { } // {
        enable = mkEnableOption "";
      };
    };
    config = mkIf config.features.${name}.enable (module.config or module);
  };
  modulesMkOption =
    config: args: path:
    (map (path: wrapMkOption config (import path args) (baseNameOf path)) (entryPaths path));
}
