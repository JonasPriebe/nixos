{
  config,
  lib,
  pkgs,
  ...
}:

{

  environment.systemPackages = with pkgs; [
    # Helix Stuff
    helix
    rust-analyzer
    marksman
    deno
    lldb
    clang-tools
    python3
    python3Packages.python-lsp-server
    rustup
    nixd
    gcc
    nil

  ];

}
