{
  config,
  lib,
  pkgs,
  modules,
  ...
}:

{
  imports = [
    modules.agenix
  ];
  # this is the user for my server instances
  users.users.euklyd = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  age = {
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };

  nix.settings.trusted-users = [
    "euklyd"
  ];
}
