{
  config,
  lib,
  pkgs,
  ...
}:
# let
#   unstable = import <nixos-unstable> {
#   };
# in
let
  unstable =
    import
      (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/tarball/fe13242281a67641c0102cdb1087f0ebe586c7df")
      {
        config = config.nixpkgs.config;
      };
in
{
  imports = [
    <nixos-unstable/nixos/modules/services/hardware/watt.nix>
  ];

  services.watt = {
    enable = true;
    package = unstable.watt;
  };
}
