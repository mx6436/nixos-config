{ lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mx";
  home.homeDirectory = "/home/mx";

  imports = [
    ../../home/core
    ../../home/desktop

    ../../home/features/fish.nix
    ../../home/features/gaming.nix
    ../../home/features/vscode.nix
    ../../home/features/wechat.nix
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "mx6436";
      user.email = "mx6436@foxmail.com";
    };
  };
}