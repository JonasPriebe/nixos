{
  self,
  pkgs,
  config,
  inputs,
  ...

}:
let
  emacs = (
    pkgs.emacs-pgtk.pkgs.withPackages (
      epkgs: with epkgs; [
        pdf-tools
        org-pdftools
      ]
    )
  );
in
{
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    # (pkgs.emacsWithPackagesFromUsePackage {
    #   package = pkgs.emacs-pgtk; # replace with pkgs.emacsPgtk, or another version if desired.
    #   config = /home/bob/.doom.d/init.el;
    #   alwaysEnsure = true;
    #   extraEmacsPackages = epkgs: [
    #     epkgs.use-package
    #     # (pkgs.ripgrep.override{pcre2=true;})
    #     epkgs.pdf-tools
    #     epkgs.org-pdftools

    #   ];
    # })
    emacs
    mu
    ripgrep
    gnutls
    git
    fd
    imagemagick
    zstd
    sqlite
    clang-tools
    texliveMedium
    age
    ty
    sbcl
    csharpier
    nixfmt
    black
    pipenv
    shfmt
    shellcheck
    pandoc

  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.symbols-only
  ];

  environment.sessionVariables.PATH = [ "/home/bob/.emacs.d/bin" ];
}
