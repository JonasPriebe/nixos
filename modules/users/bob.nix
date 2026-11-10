{
  config,
  lib,
  pkgs,
  modules,
  homeDir,
  ...
}:

{
  imports = [
    modules.agenix
  ];

  age = {
    identityPaths = [
      "${homeDir}/.ssh/id_ed25519"
    ];
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."bob" = {
    isNormalUser = true;
    description = "bob";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ ];
  };

}
