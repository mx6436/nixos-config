{ pkgs, ... }:

{
  # Font settings
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    corefonts
  ];
  fonts.fontconfig = {
    defaultFonts = {
      serif = [
        "Noto Serif CJK SC"
        "Noto Serif"
      ];
      sansSerif = [
        "Noto Sans CJK SC"
        "Noto Sans"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Sans Mono CJK SC"
      ];
    };
  };
}
