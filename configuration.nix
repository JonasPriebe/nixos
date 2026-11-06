{
  config,
  pkgs,
  lib,
  hostname,
  ...
}:
let
  modules = import ./modules { inherit lib; };
in
{
  imports = [
    (import (./hosts + "/${hostname}") {

      inherit modules;
      inherit pkgs;
      inherit config;
      inherit lib;

    })
  ];

  system.stateVersion = "26.05";
}
