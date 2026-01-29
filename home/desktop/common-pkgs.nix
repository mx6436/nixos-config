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
    (nautilus.overrideAttrs (prev: {
      buildInputs =
        prev.buildInputs
        ++ (with pkgs.gst_all_1; [
          gst-plugins-good
          gst-plugins-bad
        ]);
    }))
    papers
    loupe
    showtime
    gnome-text-editor
    wpsoffice-cn
    obs-studio
    splayer
    qq
  ];
}
