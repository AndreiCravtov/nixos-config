# Top-level flake glue to get our configuration working
{inputs, ...}: {
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];

  debug = true; # Allows nixd completions

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

    formatter = pkgs.alejandra; # For 'nix fmt'
    packages.default = self'.packages.activate; # Enables 'nix run' to activate.
    nixos-unified.primary-inputs = [
      "nixpkgs"
      "nixos-hardware"
      # "nix-darwin"
      "home-manager"
      "flake-parts"
      "nixos-unified"
      "nix-flatpak"
      "nix-vscode-extensions"
      "nix-jetbrains-plugins"
    ];
  };
}
