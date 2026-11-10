{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    git
    tig
  ];

  programs.git = {
    enable = true;
    config = {
      user.name = "Jonas Priebe";
      user.email = "61156222+JonasPriebe@users.noreply.github.com";
    };
  };
}
