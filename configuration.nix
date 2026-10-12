# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./modules/wm/sway.nix
    ./modules/apps/thunar.nix
  ];
  # Home manager
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.bob = import "/home/bob/nixos/home.nix";

  # NixOS
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Samba mount
  fileSystems."/mnt/unraid" = {
    device = "//tower/data";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [
        "${automount_opts},credentials=/etc/nixos/smb-secrets"
        "nofail"
      ];
  };

  # Docker
  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        data-root = "/home/bob/.local/share/docker";
      };
    };
  };

  # Bootloader.
  boot = {
    kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
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

  # Set your time zone.
  time = {
    timeZone = "Europe/Berlin";
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  # Configure console keymap
  console.keyMap = "us";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."bob" = {
    isNormalUser = true;
    description = "bob";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-40.10.5"
      ];
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # General usability
    vim
    wget
    wl-clipboard
    ghostty

    btop
    cifs-utils
    eddie
    obsidian
    mpv
    gimp
    jellyfin-mpv-shim
    pandoc

    # Helix Stuff
    helix
    rust-analyzer
    marksman
    deno
    lldb
    clang-tools
    python3
    python3Packages.python-lsp-server
    rustup
    nixd
    gcc

    # Audio
    pavucontrol
    pamixer
    bluez
    bluez-tools

    # Application
    vesktop
    bitwarden-desktop
    signal-desktop
    docker
    docker-compose
    darktable

    # 3D Printing
    prusa-slicer

    # home manager backup
    bat
    steel
    schemat
    mitscheme
    git
    tig
    rmpc

  ];

  # programs

  programs.xfconf.enable = true;

  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFireFoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      OverrideFirstRunPage = "";
      OverrideFirstPostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always";
      DisplayMenuBar = "default-off";
      Searchbar = "unified";

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      ExtensionSettings = {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "normal_installed";
        };
      };
    };
  };

  services.tailscale = {
    enable = true;
  };

  services.lact.enable = true;

  services.gnome.gnome-keyring.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

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

  services.udisks2.enable = true;

  services.displayManager.ly = {
    enable = true;
    settings = {
      session_log = "/tmp/ly-session.log";
    };
  };

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # security
  security.polkit.enable = true;

  security.rtkit.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.mononoki
      jetbrains-mono
    ];
    fontconfig.defaultFonts.monospace = [ "Jetbrains Mono" ];
  };
  system.stateVersion = "26.05"; # Did you read the comment?
}
