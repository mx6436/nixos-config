{ pkgs, ... }:

{
  home.packages = with pkgs; [
    helix
    git
    eza
    starship
    nixd
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };
}
