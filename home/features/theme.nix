{ pkgs, ... }:

{
  # ============================================================
  # 1. 基础依赖层
  # ============================================================
  home.packages = with pkgs; [
    # 核心组件：提供 GNOME 的 gsettings 架构定义。
    # 作用：防止在 Niri 等非 GNOME 环境下，打开 GTK 应用时出现
    # "GLib-GIO-ERROR: No GSettings schemas are installed" 崩溃或报错。
    gsettings-desktop-schemas
  ];

  # ============================================================
  # 2. GNOME / Libadwaita 核心配色 (GTK4)
  # ============================================================
  # 这里是这一代 GTK4 应用（如 Nautilus, Epiphany, Fcitx5配置页）
  # 真正读取配置的地方。
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      # 设定强调色为“岩灰” (Slate)。
      # 只有较新的 GNOME/Libadwaita 应用支持此选项。
      accent-color = "slate";

      # 全局暗色模式。
      # 建议显式设置，否则部分应用会默认回退到刺眼的亮色。
      color-scheme = "prefer-dark";
    };
  };

  # ============================================================
  # 3. GTK3 / Legacy 样式一致性
  # ============================================================
  # 这一段负责生成 gtk-3.0/settings.ini 等配置文件。
  # 作用：确保那些旧版 GTK 应用（非 Libadwaita）也能保持一致的外观。
  gtk = {
    enable = true;

    theme = {
      name = "Adwaita";
      # 使用官方的 GNOME 主题包
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      # 使用官方图标，保证系统图标（文件夹、设置齿轮等）不缺失
      package = pkgs.adwaita-icon-theme;
    };
  };

  # ============================================================
  # 4. Qt / KDE 应用桥接
  # ============================================================
  # 这是一个“伪装”层，专门处理 VLC, Telegram, OBS 等 Qt 程序。
  qt = {
    enable = true;

    # 关键设置：平台主题桥接。
    # 作用 1：让 Qt 程序使用 GTK 的文件选择对话框（而不是丑陋的默认框）。
    # 作用 2：自动读取系统的字体渲染设置。
    platformTheme.name = "gtk3";

    # 强制 Qt 使用 Adwaita 风格。
    # 虽然 Qt 不能完美渲染 "slate" 强调色，但使用 adwaita-dark
    # 能保证它们至少是暗色的，且按钮风格与系统统一。
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
