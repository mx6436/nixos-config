{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bubblewrap
    cachix
    cursor-cli
    eza
    file
    gh
    git
    helix
    inotify-tools
    jq
    nixd
    opencode
    python3
    ripgrep
    starship
    tree
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = true;
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.direnv.enable = true;
}
