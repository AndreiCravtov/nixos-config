# This is your nixos configuration.
# For home configuration, see /modules/home/*
{
  flake,
  lib,
  pkgs,
  ...
}: {
  # A module that automatically imports everything else in the parent folder.
  # NOTE: cannot use `my-util.readDirPaths` due to recursion!!
  imports = flake.config.flake.my-util.readDirPaths {readPath = ./.;};

  programs.zsh.enable = true;
  services.openssh.enable = true;

  security = lib.optionalAttrs pkgs.stdenv.isLinux {
    sudo.execWheelOnly = true;
  };
}
