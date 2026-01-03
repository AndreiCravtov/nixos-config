{pkgs, ...}: {
  # Config
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace-release; [
      tecosaur.latex-utilities
      james-yu.latex-workshop
      valentjn.vscode-ltex
      efoerster.texlab # TODO: does this clash with LaTeX workshop ??
    ];
  };
}
