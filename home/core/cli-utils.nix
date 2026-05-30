{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bubblewrap
    cachix
    eza
    file
    gh
    git
    inotify-tools
    jq
    ripgrep
    starship
    tree
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = true;
  };
}
