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
    # Temporary backport of nixpkgs c7d32bc904; remove once nixos-unstable includes it.
    (lutris.override {
      lutris-unwrapped = lutris-unwrapped.overrideAttrs (prev: {
        patches = (prev.patches or [ ]) ++ [
          (fetchpatch {
            name = "fix-GnomeDesktop-AttributeError.patch";
            url = "https://github.com/lutris/lutris/commit/fd91646fbae9b0f7ce90fb5d7dda34e8f13856fe.patch";
            hash = "sha256-FCIEawp58JR9ImsFod2TMvWdXo2PmBi+4eoJz7rgcMo=";
          })
        ];
      });
    })
    mangohud
    osu-lazer-bin
    prismlauncher
    umu-launcher
  ];

  wayland.windowManager.niri.settings.binds = {
    "Mod+G".spawn = lib.getExe gameInputHelper;
  };
}
