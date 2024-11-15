{
  config,
  lib,
  pkgs,
  ...
}@args:
with lib;
{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  config = mapAttrs (_: value: mkDefault value) (
    filterAttrs (name: _: name != "imports") (import /etc/nixos/configuration.nix args)
  );
}
