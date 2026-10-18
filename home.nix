{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.username = "bob";
  home.homeDirectory = "/home/bob";
  home.stateVersion = "26.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch -I nixos-config=/home/bob/nixos/configuration.nix";
    };
    initExtra = ''
      export PROMPT_COMMAND= PS1='\u  \w $(git branch --show-current 2>/dev/null)'
    '';
  };

  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.thunar}/bin/thunar";
      };
    };
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/home/bob/music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };

  home.packages = with pkgs; [
    ripgrep
      ];
}
