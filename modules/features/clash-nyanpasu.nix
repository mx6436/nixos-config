{ inputs, ... }:

{
  imports = [
    inputs.nur-packages.nixosModules.clash-nyanpasu
  ];

  programs.clash-nyanpasu = {
    enable = true;
    serviceMode = true;
    tunMode = true;
    autoStart = true;
    user = "mx";
  };
}
