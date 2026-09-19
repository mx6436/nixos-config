{
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    pkgs.sbctl
  ];

  # https://wiki.nixos.org/wiki/Limine
  boot.loader.limine.secureBoot.enable = true;
}
