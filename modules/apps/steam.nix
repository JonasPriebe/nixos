{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
    ];

  programs.steam = {
    enable = true;
  };

  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];

  programs.gamescope = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
  ];

}
