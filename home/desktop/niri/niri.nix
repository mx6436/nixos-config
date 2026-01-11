{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xwayland-satellite
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  programs.niri.settings = {
    input.mouse.accel-profile = "flat";

    outputs."eDP-1" = {
      mode = {
        width = 1920;
        height = 1200;
        refresh = 60.002;
      };
      scale = 1.00;
    };

    layout = {
      gaps = 3;
      background-color = "transparent";
      always-center-single-column = true;

      focus-ring = {
        width = 2;
        active = { color = "#b4befe"; };
        inactive = { color = "#505050"; };
        urgent = { color = "#9b0000"; };
      };
    };

    layer-rules = [
      {
        matches = [ { namespace = "^quickshell$"; } ];
        place-within-backdrop = true;
      }
      {
        matches = [ { namespace = "dms:blurwallpaper"; } ];
        place-within-backdrop = true;
      }
    ];

    spawn-at-startup = [
      { argv = [ "bash" "-c" "wl-paste --watch cliphist store &"]; }    
    ];

    hotkey-overlay.skip-at-startup = true;

    environment = {
      XDG_CURRENT_DESKTOP = "niri";
      QT_QPA_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
    };

    window-rules= [
      {
        matches = [ { app-id = "r#\"^org\\.gnome\\.\"#"; } ];
        draw-border-with-background = false;
        geometry-corner-radius = {
          bottom-left = 12.00;
          bottom-right = 12.00;
          top-left = 12.00;
          top-right = 12.00;
        };
        clip-to-geometry = true;
      }
      {
        matches = [
          { app-id = "r#\"^org\\.wezfurlong\\.wezterm$\"#"; }
          { app-id = "Alacritty"; }
          { app-id = "zen"; }
          { app-id = "com.mitchellh.ghostty"; }
          { app-id = "kitty"; }
        ];
        draw-border-with-background = false;
      }
      {
        matches = [ { is-active = false; } ];
        opacity = 0.9;
      }
      {
        geometry-corner-radius = {
          bottom-left = 12.00;
          bottom-right = 12.00;
          top-left = 12.00;
          top-right = 12.00;
        };
        clip-to-geometry = true;
      }
      {
        matches = [ { app-id = "r#\"org.quickshell$\"#"; } ];
        open-floating = true;
      }
    ];

    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = { };

      # 应用程序启动
      "Mod+T".action.spawn = "kitty";
      "Mod+Return".action.spawn = "firefox";
      "Mod+E".action.spawn = "nautilus";

      # 窗口与工作区管理 - 基础
      "Mod+O" = {
        action.toggle-overview = { };
        repeat = false;
      };
      "Mod+Q" = {
        action.close-window = { };
        repeat = false;
      };

      # 焦点移动 (方向键)
      "Mod+Left".action.focus-column-left = { };
      "Mod+Down".action.focus-window-down = { };
      "Mod+Up".action.focus-window-up = { };
      "Mod+Right".action.focus-column-right = { };
      "Mod+H".action.focus-column-left = { };
      "Mod+J".action.focus-window-down = { };
      "Mod+K".action.focus-window-up = { };
      "Mod+L".action.focus-column-right = { };

      # 窗口移动 (方向键)
      "Mod+Ctrl+Left".action.move-column-left = { };
      "Mod+Ctrl+Down".action.move-window-down = { };
      "Mod+Ctrl+Up".action.move-window-up = { };
      "Mod+Ctrl+Right".action.move-column-right = { };
      "Mod+Ctrl+H".action.move-column-left = { };
      "Mod+Ctrl+J".action.move-window-down = { };
      "Mod+Ctrl+K".action.move-window-up = { };
      "Mod+Ctrl+L".action.move-column-right = { };

      # 列首尾焦点/移动
      "Mod+Home".action.focus-column-first = { };
      "Mod+End".action.focus-column-last = { };
      "Mod+Ctrl+Home".action.move-column-to-first = { };
      "Mod+Ctrl+End".action.move-column-to-last = { };

      # 显示器间焦点移动
      "Mod+Shift+Left".action.focus-monitor-left = { };
      "Mod+Shift+Down".action.focus-monitor-down = { };
      "Mod+Shift+Up".action.focus-monitor-up = { };
      "Mod+Shift+Right".action.focus-monitor-right = { };
      "Mod+Shift+H".action.focus-monitor-left = { };
      "Mod+Shift+J".action.focus-monitor-down = { };
      "Mod+Shift+K".action.focus-monitor-up = { };
      "Mod+Shift+L".action.focus-monitor-right = { };

      # 列移动到显示器
      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = { };
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = { };
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = { };
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = { };
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = { };
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = { };
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = { };
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = { };

      # 工作区导航 (页面键)
      "Mod+Page_Down".action.focus-workspace-down = { };
      "Mod+Page_Up".action.focus-workspace-up = { };
      "Mod+U".action.focus-workspace-down = { };
      "Mod+I".action.focus-workspace-up = { };

      # 列移动到工作区 (页面键)
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = { };
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = { };
      "Mod+Ctrl+U".action.move-column-to-workspace-down = { };
      "Mod+Ctrl+I".action.move-column-to-workspace-up = { };

      # 工作区移动
      "Mod+Shift+Page_Down".action.move-workspace-down = { };
      "Mod+Shift+Page_Up".action.move-workspace-up = { };
      "Mod+Shift+U".action.move-workspace-down = { };
      "Mod+Shift+I".action.move-workspace-up = { };

      # 鼠标滚轮绑定
      "Mod+WheelScrollDown" = {
        action.focus-workspace-down = { };
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action.focus-workspace-up = { };
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        action.move-column-to-workspace-down = { };
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        action.move-column-to-workspace-up = { };
        cooldown-ms = 150;
      };

      "Mod+WheelScrollRight".action.focus-column-right = { };
      "Mod+WheelScrollLeft".action.focus-column-left = { };
      "Mod+Ctrl+WheelScrollRight".action.move-column-right = { };
      "Mod+Ctrl+WheelScrollLeft".action.move-column-left = { };

      "Mod+Shift+WheelScrollDown".action.focus-column-right = { };
      "Mod+Shift+WheelScrollUp".action.focus-column-left = { };
      "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = { };
      "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = { };

      # 数字工作区绑定
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      # 窗口吸收/排出
      "Mod+BracketLeft".action.consume-or-expel-window-left = { };
      "Mod+BracketRight".action.consume-or-expel-window-right = { };
      "Mod+Comma".action.consume-window-into-column = { };
      "Mod+Period".action.expel-window-from-column = { };

      # 布局调整
      "Mod+R".action.switch-preset-column-width = { };
      "Mod+Shift+R".action.switch-preset-window-height = { };
      "Mod+Ctrl+R".action.reset-window-height = { };
      "Mod+F".action.maximize-column = { };
      "Mod+Shift+F".action.fullscreen-window = { };
      "Mod+Ctrl+F".action.expand-column-to-available-width = { };
      "Mod+C".action.center-column = { };
      "Mod+Ctrl+C".action.center-visible-columns = { };

      # 精细尺寸调整
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # 浮动窗口管理
      "Mod+Space".action.toggle-window-floating = { };
      "Mod+Shift+Space".action.switch-focus-between-floating-and-tiling = { };

      # 标签式列显示
      "Mod+W".action.toggle-column-tabbed-display = { };

      # 截图功能
      "Print".action.screenshot = { };
      "Ctrl+Print".action.screenshot-screen = { };
      "Alt+Print".action.screenshot-window = { };

      # 系统控制
      "Mod+Escape" = {
        action.toggle-keyboard-shortcuts-inhibit = { };
        allow-inhibiting = false;
      };
      "Mod+Shift+E".action.quit = { };
      "Ctrl+Alt+Delete".action.quit = { };
      "Mod+Shift+P".action.power-off-monitors = { };
    };
  };
}
