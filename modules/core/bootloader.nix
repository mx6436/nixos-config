{ ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # do not need to keep too much generations
  boot.loader.systemd-boot.configurationLimit = 10;
}