{ config, ... }:

{
  programs.niri = {
    enable = true;

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
