{
  flake,
  pkgs,
  lib,
  ...
}: let
  inherit (flake) inputs config;
  inherit (inputs.self) homeModules;
in {
  # A module that automatically imports everything else in the parent folder.
  # NOTE: cannot use `my-util.readDirPaths` due to recursion!!
  imports = config.flake.my-util.readDirPaths {readPath = ./.;};

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    omnix

    # Unix tools
    gnumake
    usbutils # TODO: maybe better as part of system packages??

    # Nix dev
    cachix
    nix-info
  ];

  # Set username based on global config
  home.username = config.me.username;
}
