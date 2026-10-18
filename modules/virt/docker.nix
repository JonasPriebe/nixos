{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Docker
  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        data-root = "/home/bob/.local/share/docker";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];
}
