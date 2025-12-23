# Top-level flake glue to get our configuration working
{inputs, ...}: {
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];

  # Allows nixd completions
  debug = true;

  perSystem = {
    self',
    system,
    pkgs,
    lib,
    ...
  }: {
    # Make our overlays avaliable to the devShell
    # "Flake parts does not yet come with an endorsed module that initializes the pkgs argument."
    # So we must do this manually; https://flake.parts/overlays#consuming-an-overlay
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;

      # Permissive w.r.t. allowed packages
      config = {
        allowBroken = true;
        allowUnsupportedSystem = true;
        allowUnfree = true;
      };

      # Apply all (autowired) overlays
      overlays = lib.attrValues inputs.self.overlays;
    };

    # For 'nix fmt'
    formatter = pkgs.alejandra;

    # Enables 'nix run' to activate.
    packages.default = self'.packages.activate;
  };
}
