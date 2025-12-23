# Uses patched version of omnix;
# SEE: https://github.com/juspay/omnix/pull/489
{flake, ...}: self: super: let
  inherit (flake) inputs;
  system = super.stdenv.hostPlatform.system;
in {
  omnix = inputs.omnix-pr489.packages.${system}.default;
}
