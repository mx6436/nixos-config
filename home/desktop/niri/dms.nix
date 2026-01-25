{
  config,
  lib,
  inputs,
  ...
}:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)

    niri.includes = {
      enable = true;
    };
  };

  programs.niri.settings.binds =
    with config.lib.niri.actions;
    let
      dms-ipc = spawn "dms" "ipc";
    in
    {
      "Mod+D" = {
        action = dms-ipc "spotlight" "toggle";
        hotkey-overlay.title = "Toggle Application Launcher";
      };
      "Mod+N" = {
        action = dms-ipc "notifications" "toggle";
        hotkey-overlay.title = "Toggle Notification Center";
      };
      # "Mod+Comma" = {
      #   action = dms-ipc "settings" "toggle";
      #   hotkey-overlay.title = "Toggle Settings";
      # };
      "Mod+P" = {
        action = dms-ipc "notepad" "toggle";
        hotkey-overlay.title = "Toggle Notepad";
      };
      "Super+Alt+L" = {
        action = dms-ipc "lock" "lock";
        hotkey-overlay.title = "Toggle Lock Screen";
      };
      "Mod+X" = {
        action = dms-ipc "powermenu" "toggle";
        hotkey-overlay.title = "Toggle Power Menu";
      };
      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action = dms-ipc "audio" "increment" "3";
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action = dms-ipc "audio" "decrement" "3";
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action = dms-ipc "audio" "mute";
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action = dms-ipc "audio" "micmute";
      };
      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action = dms-ipc "brightness" "increment" "5" "";
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action = dms-ipc "brightness" "decrement" "5" "";
      };
      "Mod+Alt+N" = {
        allow-when-locked = true;
        action = dms-ipc "night" "toggle";
        hotkey-overlay.title = "Toggle Night Mode";
      };
      "Mod+V" = {
        action = dms-ipc "clipboard" "toggle";
        hotkey-overlay.title = "Toggle Clipboard Manager";
      };
    };
}
