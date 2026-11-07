{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = false;
      PasswordAuthentication = false;
    };
  };
}
