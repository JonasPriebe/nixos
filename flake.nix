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
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
    }:
    let
      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit (final) config;
                    inherit (final.stdenv.hostPlatform) system;
                  };
                })
              ];
            }
            ./hosts/${hostname}/configuration.nix
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

      };
    };
}
