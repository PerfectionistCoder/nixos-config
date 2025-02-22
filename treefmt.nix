{ pkgs, ... }:
{
  projectRootFile = "flake.nix";
  programs.nixfmt.enable = true;

  programs.shfmt = {
    enable = true;
    indent_size = 0;
  };
  programs.clang-format.enable = true;
}
