{ ... }:

{
  services.gvfs.enable = true; # For nautilus trash
  services.printing.enable = true; # Enable CUPS to print documents.
  services.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).

  programs.dconf.enable = true;
}
