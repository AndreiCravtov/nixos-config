# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.nixosModules.default
    self.nixosModules.gui

    # TODO: if I ever upgrade CPUs, change this??
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series

    ./configuration.nix
  ];
}
