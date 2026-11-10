{
  self,
  pkgs,
  ...
}:

{
  imports = [ self.inputs.agenix.nixosModules.default ];

  environment.systemPackages = [
    self.inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
