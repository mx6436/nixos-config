{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bubblewrap
    cachix
    claude-code
    cursor-cli
    eza
    file
    gh
    git
    inotify-tools
    jq
    nodejs
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
