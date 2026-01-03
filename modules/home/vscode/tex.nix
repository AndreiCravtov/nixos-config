{
  pkgs,
  lib,
  ...
}: let
  # Packages needed for this
  ltex-ls-plus = pkgs.ltex-ls-plus + /.;
in {
  # Config
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace-release; [
      tecosaur.latex-utilities
      james-yu.latex-workshop
      ltex-plus.vscode-ltex-plus
      efoerster.texlab # TODO: does this clash with LaTeX workshop ??
    ];

    userSettings = {
      "ltex.ltex-ls.path" = ltex-ls-plus;
    };
  };
}
