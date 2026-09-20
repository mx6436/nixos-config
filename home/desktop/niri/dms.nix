{
  inputs,
  ...
}:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    # enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
  };

  # DMS 运行时生成的配置片段
  wayland.windowManager.niri.extraConfig = ''
    include optional=true "dms/alttab.kdl"
    include optional=true "dms/binds.kdl"
    include optional=true "dms/colors.kdl"
    include optional=true "dms/cursor.kdl"
    include optional=true "dms/layout.kdl"
    include optional=true "dms/outputs.kdl"
    include optional=true "dms/windowrules.kdl"
    include optional=true "dms/wpblur.kdl"
  '';

  wayland.windowManager.niri.settings = {
    spawn-at-startup = [
      [
        "dms"
        "run"
      ]
    ];

    layer-rule = [
      {
        match._props.namespace = "^quickshell$";
        place-within-backdrop = true;
      }
      {
        match._props.namespace = "dms:blurwallpaper";
        place-within-backdrop = true;
      }
    ];

    window-rule = [
      {
        match._props.app-id = "org.quickshell";
        open-floating = true;
      }
    ];

    binds = {
      "Mod+D" = {
        spawn = [
          "dms"
          "ipc"
          "spotlight"
          "toggle"
        ];
        _props."hotkey-overlay-title" = "Toggle Application Launcher";
      };
      "Mod+N" = {
        spawn = [
          "dms"
          "ipc"
          "notifications"
          "toggle"
        ];
        _props."hotkey-overlay-title" = "Toggle Notification Center";
      };
      "Mod+Comma" = {
        spawn = [
          "dms"
          "ipc"
          "settings"
          "toggle"
        ];
        _props."hotkey-overlay-title" = "Toggle Settings";
      };
      "Mod+P" = {
        spawn = [
          "dms"
          "ipc"
          "notepad"
          "toggle"
        ];
        _props."hotkey-overlay-title" = "Toggle Notepad";
      };
      "Super+Alt+L" = {
        spawn = [
          "dms"
          "ipc"
          "lock"
          "lock"
        ];
        _props."hotkey-overlay-title" = "Toggle Lock Screen";
      };
      "Mod+X" = {
        spawn = [
          "dms"
          "ipc"
          "powermenu"
          "toggle"
        ];
        _props."hotkey-overlay-title" = "Toggle Power Menu";
      };
      "XF86AudioRaiseVolume" = {
        spawn = [
          "dms"
          "ipc"
          "audio"
          "increment"
          "3"
        ];
        _props."allow-when-locked" = true;
      };
      "XF86AudioLowerVolume" = {
        spawn = [
          "dms"
          "ipc"
          "audio"
          "decrement"
          "3"
        ];
        _props."allow-when-locked" = true;
      };
      "XF86AudioMute" = {
        spawn = [
          "dms"
          "ipc"
          "audio"
          "mute"
        ];
        _props."allow-when-locked" = true;
      };
      "XF86AudioMicMute" = {
        spawn = [
          "dms"
          "ipc"
          "audio"
          "micmute"
        ];
        _props."allow-when-locked" = true;
      };
      "XF86MonBrightnessUp" = {
        spawn = [
          "dms"
          "ipc"
          "brightness"
          "increment"
          "5"
          ""
        ];
        _props."allow-when-locked" = true;
      };
      "XF86MonBrightnessDown" = {
        spawn = [
          "dms"
          "ipc"
          "brightness"
          "decrement"
          "5"
          ""
        ];
        _props."allow-when-locked" = true;
      };
      "Mod+Alt+N" = {
        spawn = [
          "dms"
          "ipc"
          "night"
          "toggle"
        ];
        _props = {
          "allow-when-locked" = true;
          "hotkey-overlay-title" = "Toggle Night Mode";
        };
      };
      "Mod+V" = {
        spawn = [
          "dms"
          "ipc"
          "clipboard"
          "toggle"
        ];
        _props."hotkey-overlay-title" = "Toggle Clipboard Manager";
      };
      "Mod+M" = {
        spawn = [
          "dms"
          "ipc"
          "processlist"
          "toggle"
        ];
        _props."hotkey-overlay-title" = "Toggle Process List";
      };
    };
  };
}
