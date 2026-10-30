{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];
}
