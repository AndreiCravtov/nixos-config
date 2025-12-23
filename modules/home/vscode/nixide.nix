{
  flake,
  pkgs,
  lib,
  ...
}: let
  inherit (flake) inputs config;

  root = inputs.self + /.;
  flakeExpr = "(builtins.getFlake \"${root}\")";
  nixosConfig = "${flakeExpr}.nixosConfigurations.${config.me.hostName}";

  # Packages needed for this
  nixd = lib.getExe pkgs.nixd;
  alejandra = lib.getExe pkgs.alejandra;
in {
  programs.vscode.profiles.default = {
    # NixIDE extension
    extensions = [pkgs.vscode-marketplace.jnoortheen.nix-ide];

    # NixIDE extension configurations
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = nixd;
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [alejandra];
          };

          # This expression will be interpreted as "nixpkgs" toplevel
          # Nixd provides package, lib completion/information from it.
          #
          # Resource Usage: Entries are lazily evaluated, entire nixpkgs takes 200~300MB for just "names".
          #                 Package documentation, versions, are evaluated by-need.
          "nixpkgs" = {
            "expr" = "${nixosConfig}.pkgs";
          };

          # Define option sets (flake-parts, nixos, home-manager, etc.) for the language server to autocomplete.
          # Lazily evaluated.
          "options" = {
            # If this is ommited, default search path (<nixpkgs>) will be used.
            "nixos" = {
              "expr" = "${nixosConfig}.options";
            };

            # By default there is no home-manager options completion, thus you can add this entry.
            "home-manager" = {
              "expr" = "${nixosConfig}.options.home-manager.users.type.getSubOptions []";
            };

            # For flake-parts options.
            # Firstly read the docs here to enable "debugging", exposing declarations for nixd.
            # https://flake.parts/debug
            "flake-parts" = {
              "expr" = "${flakeExpr}.debug.options";
            };

            # For a `perSystem` flake-parts option:
            "flake-parts-perSystem" = {
              "expr" = "${flakeExpr}.currentSystem.options";
            };
          };
        };
      };
    };
  };
}
