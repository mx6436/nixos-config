# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:
let
  lanzaboote = inputs.lanzaboote;
in
{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Creates a zram block device and uses it as a swap device
  zramSwap.enable = true;

  # Enable nix commands & flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable btrfs auto scrubbing
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  # # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # do not need to keep too much generations
  boot.loader.systemd-boot.configurationLimit = 10;

  # Use linux-zen kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Fix fnmode
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';
  boot.kernelModules = [ "hid_apple" ];


  
  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.extraLocales = [ "en_US.UTF-8/UTF-8" ];
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Input Method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      qt6Packages.fcitx5-chinese-addons
    ];
  };

  # Font settings
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Noto Serif CJK SC" "serif" ];
      sansSerif = [ "Noto Sans CJK SC" "Adwaita Sana" ];
      monospace = [ "Noto Sans Mono CJK SC" "Adwaita Mono" ];
    };
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.displayManager = {
  	autoLogin.enable = true;
  	autoLogin.user = "mx";
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # onedrive by abraunegg
  services.onedrive.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mx = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "gamemode" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  # Niri
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    tunMode = true;
    autoStart = true;
  };

  programs.gamemode.enable = true;
  programs.thunderbird.enable = true;
  programs.firefox.enable = true;
  programs.fish.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    helix # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    rustup
    gcc
    clash-verge-rev

    sbctl # For debugging and troubleshooting Secure Boot.

    gnomeExtensions.appindicator
    gnomeExtensions.system-monitor

    alacritty
    fuzzel
  ];

  environment.variables.EDITOR = "hx";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
