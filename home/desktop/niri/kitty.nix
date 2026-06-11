{ ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10.5;
    };

    themeFile = "Catppuccin-Mocha";

    settings = {
      enable_audio_bell = false;
      hide_window_decorations = true;
      window_padding_width = 6;
      background_opacity = 0.95;
    };
  };
}
