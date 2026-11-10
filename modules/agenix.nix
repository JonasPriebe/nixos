{
  self,
  pkgs,
  homeDir,
  ...
}:

{
  imports = [ self.inputs.agenix.nixosModules.default ];

  environment.systemPackages = [
    self.inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  age = {
    identityPaths = [
      "${homeDir}/.ssh/id_ed25519"
      "/etc/ssh/ssh_host_ed25519_key"
    ];

    secrets.samba-creds = {
      file = ../modules/secrets/samba-creds.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
  };
}
