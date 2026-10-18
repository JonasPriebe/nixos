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

  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];

  services.lact.enable = true;

}
