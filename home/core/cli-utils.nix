{ pkgs, ... }:

{
  home.packages = with pkgs; [
    binutils
    bubblewrap
    cachix
    eza
    fastfetch
    file
    gh
    git
    inotify-tools
    jq
    ripgrep
    starship
    tldr
    tree
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = true;
  };
}
