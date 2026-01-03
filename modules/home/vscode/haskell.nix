{pkgs, ...}: {
  # Config
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace-release; [
      haskell.haskell
      phoityne.phoityne-vscode
      justusadam.language-haskell
    ];
  };
}
