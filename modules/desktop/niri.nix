{
  lib,
  inputs,
  ...
}:

{
  imports = [ inputs.niri-nix.nixosModules.default ];

  programs.niri.enable = true;
  programs.niri.withUWSM = true;

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
