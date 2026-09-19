{
  pkgs,
  pkgs-unstable,
  ...
}:

{
  home.packages = with pkgs; [
    firefox
    labwc
    loupe
    obs-studio
    papers
    showtime
    thunderbird
    wl-clipboard
    wpsoffice-cn

    pkgs-unstable.qq # older version download links will be invalid
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
