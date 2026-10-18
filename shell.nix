let
  pkgs = import <nixpkgs> {
    config = { };
    overlays = [ ];
  };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    nil
    nixd
    nixfmt
  ];
  GREETING = "Hello, Nix!";

}
