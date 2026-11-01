{
  config,
  pkgs,
  lib,
  ...
}:
let
  host = builtins.replaceStrings [ "\n" ] [ "" ] (builtins.readFile /etc/hostname);
  modules = import ./modules { inherit lib; };
in

{
  nixpkgs.config.allowUnfree = true;
  imports = [
    (import (./hosts + "/${host}") {

      inherit modules;
      inherit pkgs;
      inherit config;
      inherit lib;

    })
  ];

  # services.keyd = {
  #   enable = true;

  #   keyboards = {
  #     default = {
  #       ids = [ "*" ];

  #       settings = {
  #         main = {
  #           capslock = "overload(control, esc)";
  #         };
  #       };
  #     };
  #   };
  # };

  system.stateVersion = "26.05"; # Did you read the comment?
}
