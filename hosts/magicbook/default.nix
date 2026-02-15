{ pkgs, ... }:

{
  # Define your hostname.
  networking.hostName = "magicbook";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mx = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      "gamemode"
    ];
  };

  nix.settings.trusted-users = [ "mx" ];

  imports = [
    ./hardware-configuration.nix

    ../../modules/core
    ../../modules/desktop

    ../../modules/features/clash-verge.nix
    ../../modules/features/fcitx5.nix
    ../../modules/features/fish.nix
    ../../modules/features/gaming.nix
    ../../modules/features/onedrive.nix
    ../../modules/features/reliquary-archiver.nix
    ../../modules/features/secureboot.nix
    ../../modules/features/natfrp.nix
  ];

  # Creates a zram block device and uses it as a swap device
  zramSwap.enable = true;

  # Use linux-zen kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Fix fnmode
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';
  boot.kernelModules = [ "hid_apple" ];

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;
}
