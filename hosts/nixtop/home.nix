{ config, pkgs, ... }:
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

  # systemd.services.mpd.environment = {
  #   XDG_RUNTIME_DIR = "/run/user/${toString 1000}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  # };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "cpm_trans";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        indent-heuristic = "tree-sitter";

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
        };
      };
      keys = {
        insert = {
          esc = [
            "normal_mode"
            "save_selection"
          ];
        };
        normal = {
          ";" = "keep_primary_selection";
          "," = "collapse_selection";
          esc = "save_selection";
          space = {
            w = [
              ":format"
              ":w"
            ];
            q = ":q";
          };
          s = {
            f = "search";
            g = "global_search";
            s = "select_regex";
          };
        };
      };
    };
    languages = {
      language = [
        {
          name = "scheme";
          language-servers = [ { name = "steel-language-server"; } ];
          indent = {
            tab-width = 2;
            unit = " ";
          };
          auto-format = true;
          file-types = [ "scm" ];
          formatter = {
            command = "schemat";
            args = [ ];
          };
        }
        {
          name = "markdown";
          auto-format = true;
          formatter = {
            command = "deno";
            args = [
              "fmt"
              "-"
              "--ext"
              "md"
            ];
          };
        }
      ];

      language-server = {
        steel-language-server = {
          command = "steel-language-server";
          args = [ ];
        };
      };
    };
  };

  services.swayidle =
    let
      lock = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 120;
          command = lock;
        }
        {
          timeout = 140;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 500;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = (display "off") + "; " + lock;
        }
        {
          event = "after-resume";
          command = display "on";
        }
        {
          event = "lock";
          command = (display "off") + "; " + lock;
        }
        {
          event = "unlock";
          command = display "on";
        }
      ];
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

  home.packages = with pkgs; [
    bat
    steel
    schemat
    mitscheme
    git
    tig
    rmpc
  ];

}
