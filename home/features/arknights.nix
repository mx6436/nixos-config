{ pkgs, ... }:

{
  home.packages = with pkgs; [
    maa-cli
  ];
}
