{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    btop
    tig
    direnv
    nix-direnv
  ];

}
