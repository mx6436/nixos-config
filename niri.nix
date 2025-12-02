{ config, pkgs, niri, ... }:

{
  imports = [ niri.homeModules.niri ];
  
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;

    settings = {
      input.mouse.accel-profile = "flat";
      outputs."eDP-1" = {
        mode = {
          width = 1920;
          height = 1200;
          refresh = 60.00;
        };
        scale = 1.00;
      };
    };
  };
}
