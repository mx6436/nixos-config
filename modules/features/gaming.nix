{ pkgs, inputs, ... }:

{
  imports = [
    inputs.aagl.nixosModules.default
  ];

  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  nix.settings = inputs.aagl.nixConfig; # Set up Cachix

  programs.anime-game-launcher = {
    enable = true;
    package = pkgs.anime-game-launcher.override {
      extraPkgs = pkgs: [
        pkgs.bubblewrap
      ];
    };
  };
  programs.honkers-railway-launcher.enable = true;
}
