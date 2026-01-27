{
  inputs,
  ...
}:

{
  imports = [ inputs.natfrp.nixosModules.default ];

  services.natfrp.enable = true;
}
