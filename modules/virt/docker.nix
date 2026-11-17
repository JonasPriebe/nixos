{
  config,
  lib,
  pkgs,
  homeDir,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];

  environment.variables = {
    DOCKER_CONFIG = "${homeDir}/docker";
    MACHINE_STORAGE_PATH = "${homeDir}/docker/machine";
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };

}
