{
  config,
  lib,
  pkgs,
  modules,
  ...
}:

{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix

    modules.wm.sway

    modules.editors.emacs
    modules.editors.helix

    modules.system.fonts
    modules.system.hardware.audio
    modules.system.hardware.gpu.amd
    modules.system.security
    modules.system.settings.nix
    modules.system.settings.locale
    modules.system.hardware.bluetooth

    modules.services.ty
    modules.users.bob

    modules.apps.thunar
    modules.apps.firefox
    modules.apps.syncthing
    modules.apps.steam
    modules.apps.jetbrains
    modules.apps.mpv

    modules.apps.gimp
    modules.apps.prusaslicer
    modules.apps.darktable
    modules.apps.vesktop
    modules.apps.bitwarden
    modules.apps.signal
    modules.apps.tablet

    modules.terminal.ghostty
    modules.mounts.unraid

  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        extraEntries = {
          "windows.conf" = ''
            title Windows
            efi /EFI/Microsoft/Boot/bootmgfw.efi
          '';
        };
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixbox";
    networkmanager = {
      enable = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
  console.keyMap = "us";

  programs.xfconf.enable = true;
  # Home manager
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.bob = import "/home/bob/nixos/home.nix";

  # services.keyd = {
  #   enable = true;

  #   keyboards = {
  #     default = {
  #       ids = [ "*" ];

  #       settings = {
  #         main = {
  #           capslock = "overload(control, esc)";
  #         };
  #       };
  #     };
  #   };
  # };

  system.stateVersion = "26.05"; # Did you read the comment?
}
