{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings.theme = "catppuccin_mocha";
  };

  home.packages = with pkgs; [
    wl-clipboard
    thunderbird
    firefox
    nautilus
    papers
    loupe
    showtime
    splayer
    qq
  ];
}
