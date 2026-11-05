{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    "${builtins.fetchTarball "https://github.com/ryantm/agenix/archive/main.tar.gz"}/modules/age.nix"
  ];

  environment.systemPackages = [
    (pkgs.callPackage
      "${builtins.fetchTarball "https://github.com/ryantm/agenix/archive/main.tar.gz"}/pkgs/agenix.nix"
      { }
    )
  ];

  age = {

    identityPaths = [
      /home/bob/.ssh/id_ed25519
    ];
    secrets.samba-creds = {
      file = ../modules/secrets/samba-creds.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
  };
}
