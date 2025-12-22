{
  flake,
  pkgs,
  ...
}: {
  # Automatically import everything else in the ./vscode folder.
  # NOTE: cannot use `my-util.readDirPaths` due to recursion!!
  imports = flake.config.flake.my-util.readDirPaths {readPath = ./vscode/.;};

  programs.vscode = {
    enable = true;
    userSettings = {
      # This property will be used to generate settings.json:
      # https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
      "editor.formatOnSave" = true;
      "workbench.colorTheme" = "Dracula Theme";
    };
    keybindings = [
      # See https://code.visualstudio.com/docs/getstarted/keybindings#_advanced-customization
      #{
      #  key = "shift+ctrl+j";
      #  command = "workbench.action.focusActiveEditorGroup";
      #  when = "terminalFocus";
      #}
    ];
    extensions = with pkgs.vscode-marketplace; [
      jnoortheen.nix-ide
      dracula-theme.theme-dracula
    ];
  };
}
