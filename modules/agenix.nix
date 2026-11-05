{
  self,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ self.inputs.agenix.nixosModules.default ];

  environment.systemPackages = [
    self.inputs.agenix.packages.${pkgs.system}.default
  ];

  age = {

    identityPaths = [
      "/home/bob/.ssh/id_ed25519"
    ];
    secrets.samba-creds = {
      file = ../modules/secrets/samba-creds.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
  };
}
