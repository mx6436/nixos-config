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
      # 隐藏 Kitty 自带的标题栏和边框，让 Niri 的 focus-ring 全权接管
      hide_window_decorations = "yes";

      # 内边距 (Padding)
      # Niri 的 gaps 是 3，focus-ring 是 2。
      # 建议 Kitty 内部至少留 4-6px 的空间，否则文字贴着圆角/边框会很难看。
      window_padding_width = 5;

      # --- 视觉与透明度 ---

      # 如果你喜欢半透明 (配合 Niri 的现代感)
      # 1.0 是不透明，0.95 是轻微透明
      background_opacity = "0.95";

      # --- Wayland 性能 ---
      linux_display_server = "wayland";

      # 禁用响铃声音 (个人建议，Niri 环境下有时候挺吵)
      enable_audio_bell = "no";
    };
  };
}
