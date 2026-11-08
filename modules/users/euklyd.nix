{
  config,
  lib,
  pkgs,
  ...
}:

{
  # this is the user for my server instances
  users.users.euklyd = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
