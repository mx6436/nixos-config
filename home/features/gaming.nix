{
  lib,
  pkgs,
  ...
}:

let
  gameInputHelper = pkgs.callPackage ../../pkgs/game-input-helper/default.nix { };
in

{
  home.packages = with pkgs; [
    gameInputHelper
    gamescope
    lutris
    mangohud
    osu-lazer-bin
    umu-launcher
  ];

  wayland.windowManager.niri.settings.binds = {
    "Mod+G".spawn = lib.getExe gameInputHelper;
  };
}
