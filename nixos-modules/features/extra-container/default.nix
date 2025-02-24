{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.extra-container.overrideAttrs {
      src = pkgs.fetchFromGitHub {
        owner = "erikarvstedt";
        repo = "extra-container";
        rev = "fa723fb67201c1b4610fd3d608681da362f800eb";
        hash = "sha256-wnRkafo4YrIuvJeRsOmfStxIzi7ty2I0OtGMO9chwJc=";
      };
    })
  ];
  boot.extraSystemdUnitPaths = [ "/etc/systemd-mutable/system" ];

  networking.nat = {
    enable = true;
    internalInterfaces = [
      "ve-+"
    ];
    externalInterface = "wlp4s0";
    enableIPv6 = true;
  };

  security.polkit.extraConfig = builtins.readFile ./rules.js;
  users.groups.machine = { };
}
