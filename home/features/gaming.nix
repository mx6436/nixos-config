{ lib, pkgs, ... }:

let
  gameInputHelper = pkgs.callPackage ../../pkgs/game-input-helper/default.nix {};
in
{
  home.packages = with pkgs; [
    lutris
    mangohud
    gameInputHelper
  ];

  programs.niri.settings.binds = {
    "Mod+G".action.spawn = [ (lib.getExe gameInputHelper) ];
  };
}
