{
  pkgs,
  ...

}:
{
  environment.systemPackages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-pgtk; # replace with pkgs.emacsPgtk, or another version if desired.
      config = /home/bob/.doom.d/init.el;
      alwaysEnsure = true;
      extraEmacsPackages = epkgs: [
        epkgs.use-package
        pkgs.mu
        # (pkgs.ripgrep.override{pcre2=true;})
        pkgs.ripgrep
        pkgs.gnutls
        pkgs.git
        pkgs.fd
        pkgs.imagemagick
        pkgs.zstd
        pkgs.sqlite
        pkgs.clang-tools
        pkgs.texliveMedium
        pkgs.age
        pkgs.ty
        pkgs.sbcl
        pkgs.csharpier
        pkgs.nixfmt
        pkgs.black
        pkgs.pipenv
        pkgs.shfmt
        pkgs.shellcheck
        pkgs.direnv
        pkgs.nix-direnv
      ];
    })
  ];

  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      }
    ))
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.symbols-only
  ];
  environment.sessionVariables.PATH = [ "/home/bob/.emacs.d/bin" ];
}
