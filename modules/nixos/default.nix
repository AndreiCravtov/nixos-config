# This is your nixos configuration.
# For home configuration, see /modules/home/*
{
  flake,
  lib,
  ...
}: let
  inherit (flake) inputs config;
  inherit (config.me) hostName;
  inherit (inputs) self;

  # Check that there is a corresponding NixOS configuration set up for this host.
  checkConfigExists = val:
    config.flake.my-util.guardMsg
    (builtins.hasAttr "${hostName}" self.nixosConfigurations)
    ''
      Ensure that there is a NixOS configuration that corresponds
      to the hostName `${hostName}` (specified in repo-root's config.nix).
    ''
    val;
in {
  imports = [
    self.nixosModules.common
  ];
  services.openssh.enable = true;

  # Check that the configuration for this host exists in the autowired outputs
  # and set the `networking.hostName` to this host name
  networking.hostName = checkConfigExists (lib.mkForce hostName);
}
