{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    mpv
    jellyfin-mpv-shim
  ];
}
