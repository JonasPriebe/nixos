{
  config,
  lib,
  pkgs,
  ...
}:

{
  # i do this to spare my wrists some pain on keyboards which are non split, e.g. laptop keyboard
  services.keyd = {
    enable = true;

    keyboards = {
      default = {
        ids = [ "*" ];

        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
}
