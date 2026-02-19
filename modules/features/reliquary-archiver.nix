{ inputs, ... }:

{
  imports = [
    inputs.nur-packages.nixosModules.reliquary-archiver
  ];

  programs.reliquary-archiver.enable = true;
}
