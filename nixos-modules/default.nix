{
  config,
  lib,
  pkgs,
  ...
}@args:
let
  inherit (lib) a;
in
{
  imports = [
    ./self.nix
  ] ++ lib.modulesMkOption config args ./features;
}
