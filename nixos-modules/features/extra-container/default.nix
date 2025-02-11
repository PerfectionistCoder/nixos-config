{ ... }:
{
  programs.extra-container.enable = true;

  networking.nat = {
    enable = true;
    internalInterfaces = [
      "ve-+"
    ];
    externalInterface = "wlp4s0";
    enableIPv6 = true;
  };
}
