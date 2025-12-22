{
  flake,
  pkgs,
  config,
  ...
}: let
  inherit (flake.inputs.self.debug._module.args) root;
  flakeExpr = "(builtins.getFlake \"${root}\")";
in {
  programs.vscode = {
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = ["alejandra"];
          };

          # This expression will be interpreted as "nixpkgs" toplevel
          # Nixd provides package, lib completion/information from it.
          #
          # Resource Usage: Entries are lazily evaluated, entire nixpkgs takes 200~300MB for just "names".
          #                 Package documentation, versions, are evaluated by-need.
          "nixpkgs" = {
            # TODO: use the version with all overlays applied!!!!!!!!!!!!!!!!!!
            "expr" = "import ${flakeExpr}.inputs.nixpkgs { }";
          };

          # Define option sets (flake-parts, nixos, home-manager, etc.) for the language server to autocomplete.
          # Lazily evaluated.
          "options" = {
            # If this is ommited, default search path (<nixpkgs>) will be used.
            "nixos" = {
              # This name "nixos" could be arbitary.
              # The expression to eval, intepret it as option declarations.
              # TODO: figure out a way to wire `framework13` host more correctly!!!
              #       e.g. I need to propogate the following:
              #            -> hostname
              #            -> username
              #            -> user display name
              #            -> git name
              #            -> git email
              "expr" = "${flakeExpr}.nixosConfigurations.framework13.options";
            };

            # By default there is no home-manager options completion, thus you can add this entry.
            "home-manager" = {
              "expr" = "${flakeExpr}.nixosConfigurations.framework13.options.home-manager.users.type.getSubOptions []";
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
    extensions = [pkgs.vscode-marketplace.jnoortheen.nix-ide];
  };
}
