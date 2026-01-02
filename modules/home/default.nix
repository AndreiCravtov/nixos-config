{
  flake,
  pkgs,
  lib,
  ...
}: let
  inherit (flake) config;
in {
  # A module that automatically imports everything else in the parent folder.
  # NOTE: cannot use `my-util.readDirPaths` due to recursion!!
  imports = config.flake.my-util.readDirPaths {readPath = ./.;};

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    omnix

    # Terminal utilities
    neofetch

    # General apps
    signal-desktop
    telegram-desktop
    slack
    inkscape # TODO: change to inkscape-with-extensions??
    rust-analyzer # TODO: maybe just link to where needed, e.g. vscode & nvim repsectvely??

    # Languages with packages
    # TODO: perhaps break out into their own files??
    (python313.withPackages (ppkgs: [
      ppkgs.numpy
    ]))
    (ruby.withPackages (ps: [
      ]))

    # Nix dev
    cachix
    nix-info
  ];

  programs.obsidian.enable = true; # TODO: configure properly...???

  # Set username based on global config
  home.username = config.me.username;
}
