{ inputs, ... }:

{
  imports = [
    inputs.nur-packages.nixosModules.natfrp-service
  ];

  services.natfrp.enable = true;
}
