{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    (jetbrains.idea.override {
      vmopts = ''
        -Dawt.toolkit.name=XToolkit
        -Dsun.java2d.uiScale=1
      '';
    })
  ];
}
