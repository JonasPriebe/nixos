{ config, lib, pkgs, ... }:

{
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
 ];
}
