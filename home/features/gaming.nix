{
  lib,
  pkgs,
  ...
}:

let

  gameInputHelper = pkgs.callPackage ../../pkgs/game-input-helper/default.nix { };

  umu-launcher = pkgs.umu-launcher.overrideAttrs (prev: {
    # 修复 umu-run 时区设置不生效
    # 原因应该是 nixos 上 symlink 层数过多了
    # 用 ro-bind 方式挂载 /etc/localtime 和 /etc/zoneinfo 即可
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
    gameInputHelper
    gamescope
    lutris
    mangohud
    osu-lazer-bin
    prismlauncher
    umu-launcher
  ];

  wayland.windowManager.niri.settings.binds = {
    "Mod+G".spawn = lib.getExe gameInputHelper;
  };
}
