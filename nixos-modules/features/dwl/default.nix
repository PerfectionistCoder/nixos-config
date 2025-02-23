{ pkgs, ... }:
{
  environment.systemPackages = [
    ((pkgs.dwl.override { configH = ./config.h; }).overrideAttrs (oldAttrs: rec {
      postPatch = ''
        ${oldAttrs.postPatch}
        cp ${./dwl.c} dwl.c
      '';
      makeFlags = oldAttrs.makeFlags ++ [ "CFLAGS=-O0 -w" ];
    }))
  ];
  # patches
  /*
    alwayscenter
    autostart
    miminalborders
    mode
    simpleborders
    swapandfocusdir
    warpcursor
  */
}
