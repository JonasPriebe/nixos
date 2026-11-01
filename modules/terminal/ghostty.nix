{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./base.nix
  ];
  environment.systemPackages = with pkgs; [
    ghostty
  ];
}
