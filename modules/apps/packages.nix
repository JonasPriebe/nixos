{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Im way too lazy to seperate thest into individual modules
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # General usability
    wget
    ghostty
    btop
    mpv
    gimp
    jellyfin-mpv-shim
    pandoc
    jetbrains.idea

    # Application
    vesktop
    bitwarden-desktop
    signal-desktop
    darktable
    eddie

    # 3D Printing
    prusa-slicer

    # home manager backup
    git
    tig
    rmpc
  ];

}
