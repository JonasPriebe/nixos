{
  config,
  lib,
  pkgs,
  ...
}:

{
  # this is the user for my server instances
  users.users.vps = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
