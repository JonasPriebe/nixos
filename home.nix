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

  programs.helix = {
    extraPackages = [
      pkgs.nixd
    ];
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "cpm_trans";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        indent-heuristic = "tree-sitter";
        auto-completion = true;

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

          name = "nix";
          language-servers = [ "nixd" ];
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        }
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

        nixd = {
          command = "nixd";
          config = {
            nixd = {
              nixpkgs.expr = "(import <nixpkgs> { }";

              options = {
                nixos.expr = "(import <nixpkgs/nixos> { configuration = /home/bob/nixos/configuration.nix; }).options";
                home-manager.expr = "(import <home-manager/modules> { configuration = /home/bob/nixos/home.nix; pkgs = import <nixpkgs> {}; }).options";
              };
              formatting.command = [ "nixfmt" ];
            };

          };
        };

      };
    };

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
    bat
    steel
    schemat
    mitscheme
    git
    tig
    rmpc
  ];
}
