{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      cascadia-code
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Noto Sans CJK HK"
        ];
        serif = [ "Noto Serif CJK HK" ];
        monospace = [
          "Cascadia Mono NF"
          "Noto Sans Mono CJK HK"
        ];
      };
    };
  };
}
