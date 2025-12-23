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

  # Disable documentation app
  documentation.doc.enable = false;

  # Enable SSH systemwide
  services.openssh.enable = true;

  # Apply systemwide security hardening
  security = lib.optionalAttrs pkgs.stdenv.isLinux {
    sudo.execWheelOnly = true;
  };

  # Enable ZSH systemwide
  programs.zsh.enable = true;
}
