{ pkgs, ... }:
let
  inherit (pkgs) fetchFromGitHub;
in
{
  nixpkgs.overlays = [
    (final: prev: {
      extra-container = prev.extra-container.overrideAttrs {
        src = fetchFromGitHub {
          owner = "erikarvstedt";
          repo = "extra-container";
          rev = "fa723fb67201c1b4610fd3d608681da362f800eb";
          hash = "sha256-wnRkafo4YrIuvJeRsOmfStxIzi7ty2I0OtGMO9chwJc=";
        };
      };
    })
  ];
}
