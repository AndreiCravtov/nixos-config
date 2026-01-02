{pkgs, ...}: {
  # Config
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace; [
      teabyii.ayu
      vscode-icons-team.vscode-icons
    ];
    userSettings = {
      "workbench.colorTheme" = "Ayu Mirage Bordered";
      "workbench.iconTheme" = "vscode-icons";

      "editor.fontFamily" = "'JetBrainsMono Nerd Font'";
      "editor.fontLigatures" = true;

      "terminal.integrated.fontLigatures.enabled" = true;
      "terminal.integrated.cursorStyle" = "line";
      "terminal.integrated.cursorStyleInactive" = "line";
      "terminal.integrated.cursorBlinking" = true;
    };
  };

  # Dependencies
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
