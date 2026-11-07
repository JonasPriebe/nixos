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
