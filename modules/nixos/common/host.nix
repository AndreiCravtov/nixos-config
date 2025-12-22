# Check that the configuration for host specified in (root) config.nix exists
# in the autowired outputs and set the `networking.hostName` to this host name.
{
  flake,
  lib,
  ...
}: let
  inherit (flake) inputs config;
  inherit (config.me) hostName;
  inherit (inputs.self) nixosConfigurations;

  # Check that there is a corresponding NixOS configuration set up for this host.
  ensureConfigExists =
    config.flake.my-util.guardMsg
    (builtins.hasAttr "${hostName}" nixosConfigurations)
    ''
      Ensure that there is a NixOS configuration that corresponds
      to the hostName `${hostName}` (specified in repo-root's config.nix).
    '';
in {
  networking.hostName = ensureConfigExists (lib.mkForce hostName);
}
