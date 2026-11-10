{
  config,
  lib,
  pkgs,
  modules,
  ...
}:

{
  imports = [
    modules.terminal.git
  ];

  environment.systemPackages = with pkgs; [
    wget
    btop
    tig
    direnv
    nix-direnv
  ];

}
