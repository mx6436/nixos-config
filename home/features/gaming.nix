{
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) system;
  gameInputHelper = pkgs.callPackage ../../pkgs/game-input-helper/default.nix { };
  umu-launcher =
    (inputs.umu.packages.${system}.default.override (prev: {
      umu-launcher-unwrapped = prev.umu-launcher-unwrapped.overrideAttrs {
        doInstallCheck = false;
      };
    })).overrideAttrs
      (prev: {
        # 修复umu-run时区不生效
        # 原因应该是nixos上symlink层数过多了
        # 用ro-bind方式挂载/etc/localtime和/etc/zoneinfo即可
        buildCommand = (prev.buildCommand or "") + ''
          sed -i 's| /etc/localtime||g' $out/bin/umu-run
          sed -i 's| /etc/zoneinfo||g' $out/bin/umu-run

          sed -i '/ro_mounts=()/a \
          ro_mounts+=(--ro-bind /etc/localtime /etc/localtime)\
          ro_mounts+=(--ro-bind /etc/zoneinfo /etc/zoneinfo)' \
          "$out/bin/umu-run"
        '';
      });
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
    umu-launcher
  ];

  programs.niri.settings.binds = {
    "Mod+G".action.spawn = [ (lib.getExe gameInputHelper) ];
  };
}
