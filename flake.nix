{
  description = "My config to to create Euklyd.";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org" # emacs-community-overlay
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    let
      mkHost =
        hostname:
        let
          system = "x86_64-linux";
          lib = nixpkgs.lib;

          users = {
            nixbox = "bob";
            nixtop = "bob";
            vps = "euklyd";
          };

          username = users.${hostname};
          homeDir = "/home/${username}";
        in
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit self inputs homeDir;
            modules = import ./modules { inherit lib; };
          };

          module = [
            {
              nixpkgs.config.allowUnfreePredicate =
                pkg:
                builtins.elem (lib.getName pkg) [
                  "idea"
                  "steam"
                  "steam-unwrapped"
                ];

              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit (final) config;
                    inherit (final.stdenv.hostPlatform) system;
                  };
                })
              ];
            }
            ./hosts/${hostname}/default.nix
            {
              networking.hostName = hostname;
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        nixbox = mkHost "nixbox";
        nixtop = mkHost "nixtop";
        vps = mkHost "euklyd";
      };
    };
}
