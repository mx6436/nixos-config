{ pkgs, ... }:

{
  home.packages = [
    (pkgs.ffmpeg-full.override { withUnfree = true; })
  ];
}
