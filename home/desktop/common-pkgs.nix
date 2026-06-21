{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cider-2
    firefox
    gnome-text-editor
    labwc
    loupe
    obs-studio
    papers
    qq
    showtime
    thunderbird
    wl-clipboard
    wpsoffice-cn

    (nautilus.overrideAttrs (prev: {
      buildInputs =
        prev.buildInputs
        ++ (with pkgs.gst_all_1; [
          gst-plugins-good
          gst-plugins-bad
        ]);
    }))
  ];
}
