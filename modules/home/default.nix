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

  # Install fonts for user
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Set username based on global config
  home.username = config.me.username;
}
