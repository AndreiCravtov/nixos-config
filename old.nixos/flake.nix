{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };

      # Parametrized config
      mkSystem =
        path:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            inputs.home-manager.nixosModules.default # Home manager
            inputs.nix-flatpak.nixosModules.nix-flatpak # Flatpak management
            path # Main config
          ];
        };

      # Concrete configs
      razerLaptop = mkSystem ./hosts/razer-laptop/configuration.nix;
    in
    {
      nixosConfigurations.nixos = razerLaptop; # use "nixos" as the name of the configuration
    };
}
