# Applies https://github.com/nix-community/nix-vscode-extensions
# TODO: and in the future maybe https://github.com/nix-community/nix4vscode too??
{flake, ...}: flake.inputs.nix-vscode-extensions.overlays.default
