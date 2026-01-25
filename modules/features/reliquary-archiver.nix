{ inputs, ... }:

{
  imports = [
    inputs.reliquary-archiver.nixosModules.default
  ];

  programs.reliquary-archiver.enable = true;
}
