{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # Bootloader.
  boot = {
    kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        extraEntries = {
          "windows.conf" = ''
            title Windows
            efi /EFI/Microsoft/Boot/bootmgfw.efi
          '';
        };
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixbox";
    networkmanager = {
      enable = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

}
