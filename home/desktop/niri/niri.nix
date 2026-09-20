{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.niri-nix.homeModules.default ];

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  wayland.windowManager.niri = {
    enable = true;

    settings = {
      input = {
        mouse.accel-profile = "flat";

        keyboard = {
          repeat-delay = 600;
          repeat-rate = 25;
        };

        touchpad = {
          tap = [ ];
          natural-scroll = [ ];
        };
      };

      output = [
        {
          _args = [ "eDP-1" ];
          mode = "1920x1200@60.002";
          scale = 1.0;
        }
      ];

      layout = {
        gaps = 3;
        background-color = "transparent";
        always-center-single-column = [ ];

        default-column-width = { };

        focus-ring = {
          width = 2;
          active-color = "#b4befe";
          inactive-color = "#505050";
          urgent-color = "#9b0000";
        };
      };

      hotkey-overlay.skip-at-startup = [ ];

      environment = {
        XDG_CURRENT_DESKTOP = "niri";
        QT_QPA_PLATFORM = "wayland";
      };

      window-rule = [
        {
          match = [
            { _props.app-id._raw = ''r#"^org\.wezfurlong\.wezterm$"#''; }
            { _props.app-id = "Alacritty"; }
            { _props.app-id = "zen"; }
            { _props.app-id = "com.mitchellh.ghostty"; }
            { _props.app-id = "kitty"; }
          ];
          draw-border-with-background = false;
        }
        {
          match._props.is-active = false;
          opacity = 0.9;
        }
        {
          geometry-corner-radius = [
            12
            12
            12
            12
          ];
          clip-to-geometry = true;
        }
        {
          match = [
            { _props.app-id = "labwc"; }
            { _props.app-id = "wlroots"; }
          ];
          open-floating = true;
          default-column-width.fixed = 1280;
          default-window-height.fixed = 720;
        }
      ];

      binds = {
        "Mod+Shift+Slash".show-hotkey-overlay = [ ];

        # 应用程序启动
        "Mod+T".spawn = "kitty";
        "Mod+Return".spawn = "firefox";
        "Mod+E".spawn = "nautilus";

        # 窗口与工作区管理 - 基础
        "Mod+O" = {
          toggle-overview = [ ];
          _props.repeat = false;
        };
        "Mod+Q" = {
          close-window = [ ];
          _props.repeat = false;
        };

        # 焦点移动 (方向键)
        "Mod+Left".focus-column-left = [ ];
        "Mod+Down".focus-window-down = [ ];
        "Mod+Up".focus-window-up = [ ];
        "Mod+Right".focus-column-right = [ ];
        "Mod+H".focus-column-left = [ ];
        "Mod+J".focus-window-down = [ ];
        "Mod+K".focus-window-up = [ ];
        "Mod+L".focus-column-right = [ ];

        # 窗口移动 (方向键)
        "Mod+Ctrl+Left".move-column-left = [ ];
        "Mod+Ctrl+Down".move-window-down = [ ];
        "Mod+Ctrl+Up".move-window-up = [ ];
        "Mod+Ctrl+Right".move-column-right = [ ];
        "Mod+Ctrl+H".move-column-left = [ ];
        "Mod+Ctrl+J".move-window-down = [ ];
        "Mod+Ctrl+K".move-window-up = [ ];
        "Mod+Ctrl+L".move-column-right = [ ];

        # 列首尾焦点/移动
        "Mod+Home".focus-column-first = [ ];
        "Mod+End".focus-column-last = [ ];
        "Mod+Ctrl+Home".move-column-to-first = [ ];
        "Mod+Ctrl+End".move-column-to-last = [ ];

        # 显示器间焦点移动
        "Mod+Shift+Left".focus-monitor-left = [ ];
        "Mod+Shift+Down".focus-monitor-down = [ ];
        "Mod+Shift+Up".focus-monitor-up = [ ];
        "Mod+Shift+Right".focus-monitor-right = [ ];
        "Mod+Shift+H".focus-monitor-left = [ ];
        "Mod+Shift+J".focus-monitor-down = [ ];
        "Mod+Shift+K".focus-monitor-up = [ ];
        "Mod+Shift+L".focus-monitor-right = [ ];

        # 列移动到显示器
        "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = [ ];
        "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = [ ];
        "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = [ ];
        "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = [ ];
        "Mod+Shift+Ctrl+H".move-column-to-monitor-left = [ ];
        "Mod+Shift+Ctrl+J".move-column-to-monitor-down = [ ];
        "Mod+Shift+Ctrl+K".move-column-to-monitor-up = [ ];
        "Mod+Shift+Ctrl+L".move-column-to-monitor-right = [ ];

        # 工作区导航 (页面键)
        "Mod+Page_Down".focus-workspace-down = [ ];
        "Mod+Page_Up".focus-workspace-up = [ ];
        "Mod+U".focus-workspace-down = [ ];
        "Mod+I".focus-workspace-up = [ ];

        # 列移动到工作区 (页面键)
        "Mod+Ctrl+Page_Down".move-column-to-workspace-down = [ ];
        "Mod+Ctrl+Page_Up".move-column-to-workspace-up = [ ];
        "Mod+Ctrl+U".move-column-to-workspace-down = [ ];
        "Mod+Ctrl+I".move-column-to-workspace-up = [ ];

        # 工作区移动
        "Mod+Shift+Page_Down".move-workspace-down = [ ];
        "Mod+Shift+Page_Up".move-workspace-up = [ ];
        "Mod+Shift+U".move-workspace-down = [ ];
        "Mod+Shift+I".move-workspace-up = [ ];

        # 鼠标滚轮绑定
        "Mod+WheelScrollDown" = {
          focus-workspace-down = [ ];
          _props."cooldown-ms" = 150;
        };
        "Mod+WheelScrollUp" = {
          focus-workspace-up = [ ];
          _props."cooldown-ms" = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          move-column-to-workspace-down = [ ];
          _props."cooldown-ms" = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          move-column-to-workspace-up = [ ];
          _props."cooldown-ms" = 150;
        };

        "Mod+WheelScrollRight".focus-column-right = [ ];
        "Mod+WheelScrollLeft".focus-column-left = [ ];
        "Mod+Ctrl+WheelScrollRight".move-column-right = [ ];
        "Mod+Ctrl+WheelScrollLeft".move-column-left = [ ];

        "Mod+Shift+WheelScrollDown".focus-column-right = [ ];
        "Mod+Shift+WheelScrollUp".focus-column-left = [ ];
        "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = [ ];
        "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = [ ];

        # 数字工作区绑定
        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;

        "Mod+Ctrl+1".move-column-to-workspace = 1;
        "Mod+Ctrl+2".move-column-to-workspace = 2;
        "Mod+Ctrl+3".move-column-to-workspace = 3;
        "Mod+Ctrl+4".move-column-to-workspace = 4;
        "Mod+Ctrl+5".move-column-to-workspace = 5;
        "Mod+Ctrl+6".move-column-to-workspace = 6;
        "Mod+Ctrl+7".move-column-to-workspace = 7;
        "Mod+Ctrl+8".move-column-to-workspace = 8;
        "Mod+Ctrl+9".move-column-to-workspace = 9;

        # 窗口吸收/排出
        "Mod+BracketLeft".consume-or-expel-window-left = [ ];
        "Mod+BracketRight".consume-or-expel-window-right = [ ];
        "Mod+Period".expel-window-from-column = [ ];

        # 布局调整
        "Mod+R".switch-preset-column-width = [ ];
        "Mod+Shift+R".switch-preset-column-width-back = [ ];
        "Mod+Ctrl+Shift+R".switch-preset-window-height = [ ];
        "Mod+Ctrl+R".reset-window-height = [ ];

        "Mod+F".maximize-column = [ ];
        "Mod+Shift+F".fullscreen-window = [ ];
        "Mod+Ctrl+F".expand-column-to-available-width = [ ];
        "Mod+C".center-column = [ ];
        "Mod+Ctrl+C".center-visible-columns = [ ];

        # 精细尺寸调整
        "Mod+Minus".set-column-width = "-10%";
        "Mod+Equal".set-column-width = "+10%";
        "Mod+Shift+Minus".set-window-height = "-10%";
        "Mod+Shift+Equal".set-window-height = "+10%";

        # 浮动窗口管理
        "Mod+Space".toggle-window-floating = [ ];
        "Mod+Shift+Space".switch-focus-between-floating-and-tiling = [ ];

        # 标签式列显示
        "Mod+W".toggle-column-tabbed-display = [ ];

        # 截图功能
        "Print".screenshot = [ ];
        "Ctrl+Print".screenshot-screen = [ ];
        "Alt+Print".screenshot-window = [ ];

        # 系统控制
        "Mod+Escape" = {
          toggle-keyboard-shortcuts-inhibit = [ ];
          _props."allow-inhibiting" = false;
        };
        "Mod+Shift+E".quit = [ ];
        "Ctrl+Alt+Delete".quit = [ ];
        "Mod+Shift+P".power-off-monitors = [ ];
      };
    };
  };
}
