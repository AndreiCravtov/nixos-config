# Uses patched version of omnix;
# SEE: https://github.com/juspay/omnix/pull/489
{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in
  self: super: {
    omnix = inputs.omnix-pr489.packages.${self.stdenv.hostPlatform.system}.default;
  }
