{
  description = "A home-manager template providing useful tools & settings for Nix-based development";

  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nix-darwin.url = "github:LnL7/nix-darwin";
    #nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Software inputs
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nixvim.url = "github:nix-community/nixvim";
    #nixvim.inputs.nixpkgs.follows = "nixpkgs";
    #nixvim.inputs.flake-parts.follows = "flake-parts";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-jetbrains-plugins.url = "github:nix-community/nix-jetbrains-plugins";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord.url = "github:kaylorben/nixcord";

    # Transient inputs for patching
    omnix-pr489.url = "github:juspay/omnix/0a0dfd462c182e2421cfa8f0d3a511003ab810a0"; # See https://github.com/juspay/omnix/pull/489
  };

  # Wired using https://nixos-unified.org/guide/autowiring
  outputs = inputs:
    inputs.nixos-unified.lib.mkFlake
    {
      inherit inputs;
      root = ./.;
      systems = ["x86_64-linux" "aarch64-linux"];
    };
}
