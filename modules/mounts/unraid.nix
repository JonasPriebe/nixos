{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  # Samba mount
  fileSystems."/mnt/unraid" = {
    device = "//tower/data";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [
        "${automount_opts},credentials=${config.age.secrets.samba-creds.path}"
        "nofail"
      ];
  };

}
