{
  flake,
  pkgs,
  lib,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  nixpkgs = {
    # Permissive w.r.t. allowed packages
    config = {
      allowBroken = true;
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };

    # Apply all (autowired) overlays
    overlays = lib.attrValues self.overlays;
  };

  nix = {
    # Choose from https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=nix
    # package = pkgs.nixVersions.latest;

    nixPath = ["nixpkgs=${flake.inputs.nixpkgs}"]; # Enables use of `nix-shell -p ...` etc
    registry.nixpkgs.flake = flake.inputs.nixpkgs; # Make `nix shell` etc use pinned nixpkgs

    settings = {
      experimental-features = ["nix-command" "flakes"];
      # Nullify the registry for purity.
      flake-registry = builtins.toFile "empty-flake-registry.json" ''{"flakes":[],"version":2}'';
      trusted-users = ["root" "@wheel"];
    };
  };
}
