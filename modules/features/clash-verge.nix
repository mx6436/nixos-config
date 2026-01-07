{ pkgs, ... }:

{
  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    tunMode = true;
    autoStart = true;
  };

  environment.systemPackages = with pkgs; [
    clash-verge-rev
  ];
}