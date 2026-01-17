{ lib, pkgs, ... }:

let
  gameInputHelper = pkgs.callPackage ../../pkgs/game-input-helper/default.nix {};
in
{
  home.packages = with pkgs; [
    mangohud
    gamescope
    gameInputHelper
    (lutris.override {
      extraPkgs = pkgs: [
        wineWowPackages.stagingFull
      ];
    })
  ];

  programs.niri.settings.binds = {
    "Mod+G".action.spawn = [ (lib.getExe gameInputHelper) ];
  };
}
