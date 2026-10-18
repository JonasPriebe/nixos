{
  config,
  lib,
  pkgs,
  ...
}:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.mononoki
      jetbrains-mono
    ];
    fontconfig.defaultFonts.monospace = [ "Jetbrains Mono" ];
  };
}
