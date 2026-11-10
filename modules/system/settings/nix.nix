{
  config,
  lib,
  pkgs,
  ...
}:

{
  # NixOS
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
