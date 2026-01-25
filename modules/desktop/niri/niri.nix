{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  environment.variables = {
    # Default settings are GTK_IM_MODULE=fcitx
    # fcitx5 recommends not to set this variable with wayland compositor
    # but niri has a bug which disables the pop-up menus
    # See https://github.com/YaLTeR/niri/issues/454
    #
    # UPDATE: issues#454 fixed in 2025.12
    GTK_IM_MODULE = lib.mkForce "";
  };
}
