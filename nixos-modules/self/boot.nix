{ lib, ... }:
{
  boot.loader = {
    timeout = lib.mkDefault 3;
  };
}
