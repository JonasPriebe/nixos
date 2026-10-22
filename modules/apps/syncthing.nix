{ config, lib, pkgs, ... }:

{

  services.syncthing ={
    enable=true;
    user="bob";
    group="users";

    configDir ="/home/bob/.config/syncthing";
    dataDir = "/var/lib/syncthing";
   };

}
