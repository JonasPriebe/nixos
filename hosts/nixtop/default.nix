# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  modules,
  ...
}:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    modules.system.hardware.laptop.integratedGraphics
    modules.system.hardware.laptop.battery
    modules.system.hardware.audio
    modules.system.hardware.bluetooth
    modules.system.hardware.lidswitch
    modules.system.hardware.network

    modules.system.security
    modules.system.fonts

    modules.system.settings.locale
    modules.system.settings.capstoctrlescape

    modules.editors.emacs
    modules.editors.helix

    modules.apps.syncthing
    modules.apps.tailscale
    modules.apps.vesktop
    modules.apps.bitwarden
    modules.apps.signal
    modules.apps.firefox
    modules.apps.thunar
    modules.apps.jetbrains
    modules.apps.mpv

    modules.terminal.ghostty

    modules.wm.sway

    modules.services.ty

    modules.users.bob

    (import "${home-manager}/nixos")
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.bob = import "/home/bob/nixos/hosts/nixtop/home.nix";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-0ae55978-0834-4aa1-9f28-cc0cd319a9ad".device =
    "/dev/disk/by-uuid/0ae55978-0834-4aa1-9f28-cc0cd319a9ad";
  networking.hostName = "nixtop";

  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  console.keyMap = "de-latin1-nodeadkeys";

  environment.systemPackages = with pkgs; [
    cifs-utils
    eddie

  ];

  system.stateVersion = "26.05";
}
