{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      session_log = "/tmp/ly-session.log";
    };
  };
}
