# This is your nixos configuration.
# For home configuration, see /modules/home/*
{
  flake,
  lib,
  pkgs,
  ...
}: {
  imports = [
    flake.inputs.self.nixosModules.common
  ];

  programs.zsh.enable = true;
  services.openssh.enable = true;

  security = lib.optionalAttrs pkgs.stdenv.isLinux {
    sudo.execWheelOnly = true;
  };
}
