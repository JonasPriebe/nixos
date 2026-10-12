let
  pkgs = import <nixpkgs> {
    config = { };
    overlays = [ ];
  };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    cowsay
    lolcat
  ];
  GREETING = "Hello, Nix!";

}
