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
      PermitRootLogiin = "no";
      PasswordAuthentication = false;
      AllowUsers = [ "euklyd" ];
    };
  };
}
