{ pkgs, ... }:

{
  # Font settings
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    maple-mono.NF
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
        "Maple Mono NF"
        "Noto Sans Mono CJK SC"
      ];
    };
  };
}
