{
  pkgs,
  ...
}:
{

  # programs
  programs.thunar = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    file-roller
    libopenraw
    tumbler

  ];
  # Add the archive plugin and an archive manager backend (e.g., file-roller or ark)
  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
  ];

  # Services
  services.tumbler.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
