# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
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
    ../../modules/system/hardware/laptop/integratedGraphics.nix
    ../../modules/system/hardware/laptop/battery.nix
    ../../modules/system/settings/capstoctrlescape.nix
    ../../modules/apps/syncthing.nix
    (import "${home-manager}/nixos")
  ];
  environment.variables.NEWT_COLORS = "root=#FFFFFF,#000000 border=#FF00FF,#000000 window=#000000,#000000 shadow=#000000,#000000 title=#FF00FF,#000000 button=#000000,#FF00FF button_active=#000000,#FFFF00 actbutton=#FFFF00,#000000 compactbutton=#FFFF00,#000000 checkbox=#FF0000,#000000 entry=#00FF00,#000000 disentry=#000000,#000000 textbox=#00FF00,#000000 acttextbox=#FF00FF,#000000 label=#00FFFF,#000000 listbox=#00FF00,#000000 actlistbox=#FF00FF,#000000 sellistbox=#FF0000,#000000 actsellistbox=#000000,#FFFF00";

  services.logind = {
    settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
    };
  };

  # Home manager
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.bob = import "/home/bob/nixos/hosts/nixtop/home.nix";

  # Docker
  virtualisation.docker = {
    enable = true;
  };

  virtualisation.docker.daemon.settings = {
    data-root = "/home/bob/.local/share/docker";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-0ae55978-0834-4aa1-9f28-cc0cd319a9ad".device =
    "/dev/disk/by-uuid/0ae55978-0834-4aa1-9f28-cc0cd319a9ad";
  networking.hostName = "nixtop"; # Define your hostname.
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

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
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # General usability
    vim
    wget
    wl-clipboard
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

    # Helix Stuff
    helix
    nil
    rust-analyzer
    marksman
    deno
    lldb
    clang-tools
    python3
    python3Packages.python-lsp-server
    rustup
    gcc

    # Audio
    pavucontrol
    pamixer
    bluez
    bluez-tools

    # Sway
    swaybg
    fuzzel
    waybar
    swaylock
    slurp

    # Application
    vesktop
    bitwarden-desktop
    signal-desktop
    docker
    docker-compose
    darktable

  ];

  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.tumbler.enable = true;

  # Add the archive plugin and an archive manager backend (e.g., file-roller or ark)
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
  ];

  services.gvfs.enable = true;

  services.tailscale = {
    enable = true;
  };

  services.gnome.gnome-keyring.enable = true;

  security.polkit.enable = true;

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

  services.blueman.enable = true;
  services.xserver.enable = false;
  # services.power-profiles-daemon.enable = true;
  services.udisks2.enable = true;

  services.displayManager.ly = {
    enable = true;
    settings = {
      session_log = "/tmp/ly-session.log";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.mononoki
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    openFirewall = true;

  };

  systemd.user.services.sunshine = {

    environment = {
      WAYLAND_DISPLAY = "wayland-1";
      XDG_RUNTIME_DIR = "/run/user/1000";
    };
  };

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

  #Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  system.stateVersion = "26.05"; # Did you read the comment?
}
