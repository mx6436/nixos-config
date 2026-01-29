{ pkgs, ... }:

{
  home.packages = with pkgs; [
    helix
    git
    eza
    starship
    nixd
    bubblewrap
    inotify-tools

    (ffmpeg-full.override { withUnfree = true; })
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.direnv.enable = true;
}
