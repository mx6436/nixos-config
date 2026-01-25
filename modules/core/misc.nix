{ ... }:

{
  # Enable nix commands & flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;
}
