{
  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # lanzaboote for secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, niri, noctalia, ... }:
  {
    # NOTE: 'nixos' is the default hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        niri.nixosModules.niri
        
        inputs.lanzaboote.nixosModules.lanzaboote

        # 将 home-manager 配置为 nixos 的一个 module
        # 这样在 nixos-rebuild switch 时，home-manager 配置也会被自动部署
        home-manager.nixosModules.home-manager
        {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs;
            home-manager.users.mx = {
              imports = [
                ./home.nix
                ./niri.nix
                ./noctalia.nix
              ];
            };
        }

        # AAGL
        {
          imports = [ inputs.aagl.nixosModules.default ];
          # nix.settings = inputs.aagl.nixConfig; # Set up Cachix
          # programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
          # programs.anime-games-launcher.enable = true;
          programs.honkers-railway-launcher.enable = true;
          # programs.honkers-launcher.enable = true;
          # programs.wavey-launcher.enable = true;
          programs.sleepy-launcher.enable = true;
        }
      ];
    };
  };
}
