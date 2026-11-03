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
    ../../modules/editors/emacs.nix

    modules.system.hardware.laptop.integratedGraphics
    modules.system.hardware.laptop.battery

    modules.system.settings.locale
    modules.system.settings.capstoctrlescape
    modules.apps.syncthing
    modules.apps.tailscale
    modules.system.hardware.audio
    modules.system.hardware.bluetooth
    modules.system.hardware.lidswitch
    modules.system.security
    modules.system.hardware.network
    modules.system.fonts
    modules.wm.sway
    modules.apps.firefox
    modules.services.ty
    modules.apps.thunar
    modules.users.bob

    (import "${home-manager}/nixos")
  ];

  # Home manager
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.bob = import "/home/bob/nixos/hosts/nixtop/home.nix";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-0ae55978-0834-4aa1-9f28-cc0cd319a9ad".device =
    "/dev/disk/by-uuid/0ae55978-0834-4aa1-9f28-cc0cd319a9ad";
  networking.hostName = "nixtop"; # Define your hostname.

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # General usability
    vim
    wget

    mako
    ghostty
    libopenraw
    tumbler
    btop
    cifs-utils
    eddie
    file-roller
    obsidian
    mpv
    gimp
    jellyfin-mpv-shim
    pandoc
    jellyfin-desktop
    jetbrains.idea
    jdk25

    # Application
    vesktop
    bitwarden-desktop
    signal-desktop
    docker
    docker-compose
    darktable

  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
