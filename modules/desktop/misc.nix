{ ... }:

{
  services.gvfs.enable = true; # For nautilus trash
  services.printing.enable = true; # Enable CUPS to print documents.
  services.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).

  # DMS (DankMaterialShell) optional features, checked by `dms doctor`
  services.accounts-daemon.enable = true; # AccountsService (DBus org.freedesktop.Accounts), for user accounts / profile picture
  services.geoclue2.enable = true; # Geolocation, used by weather/location widgets

  programs.dconf.enable = true;
}
