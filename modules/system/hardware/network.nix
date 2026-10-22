{ config, lib, pkgs, ... }:

{
  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };
networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
}
