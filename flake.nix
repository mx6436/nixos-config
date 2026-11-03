{
  description = "Nix flake of mx6436's NixOS configuration";

  inputs = {

    # --------- Core ---------

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --------- Desktop ---------

    niri-nix = {
      url = "git+https://codeberg.org/BANanaD3V/niri-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --------- NUR ---------

    nur-packages = {
      url = "github:mx6436/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      hmConfig = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit inputs;
        };
        home-manager.users.mx = import ./users/mx/home.nix;
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;

      nixosConfigurations.magicbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/magicbook

          # Temporary: lutris FHS env still pulls gtk2, which nixpkgs marks broken.
          { nixpkgs.config.problems.handlers."gtk+".broken = "warn"; }

          home-manager.nixosModules.home-manager
          hmConfig
        ];
      };
    };
}
