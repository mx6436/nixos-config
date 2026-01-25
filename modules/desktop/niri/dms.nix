{ ... }:

{
  systemd.user.services.niri-flake-polkit.enable = false; # Disable niri-flake's default polkit agent to avoid conflicts
}
