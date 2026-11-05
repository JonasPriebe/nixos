{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.watt = {
    enable = true;
    package = pkgs.unstable.watt;
  };
}
