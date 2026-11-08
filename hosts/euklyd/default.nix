{
  modules,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    modules.editors.helix

    modules.system.fonts
    modules.system.settings.nix
    modules.system.settings.locale

    modules.users.euklyd

    modules.apps.syncthing
    modules.services.ssh
    modules.agenix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  networking = {
    hostName = "euklyd";
    networkmanager = {
      enable = true;
    };
  };

  # we need to gurantee to at least have an editor on the system
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  systemd.services.NetworkManager-wait-online.enable = false;
  console.keyMap = "us";

  system.stateVersion = "26.05";
}
