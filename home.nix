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
          esc = "save_selection";
          space = {
            w = [
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
      ];

      language-server = {
        steel-language-server = {
          command = "steel-language-server";
          args = [ ];
        };
      };
    };
  };


  programs.obsidian = {
    enable = true;

    vaults.notes.target = "Documents/Obsidian";

    defaultSettings.app = {
      alwaysUpdateLinks = true;
      spellcheck = true;
      vimMode = true;
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

  home.packages = with pkgs; [
    bat
    steel
    schemat
    mitscheme
  ];

}
