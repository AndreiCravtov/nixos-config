{
  flake,
  pkgs,
  config,
  ...
}: let
  inherit (flake.config.flake) my-util;
in {
  # A module that automatically imports everything else in the parent folder.
  # NOTE: cannot use `my-util.readDirPaths` due to recursion!!
  imports = my-util.readDirPaths {readPath = ./.;};

  home.shellAliases = {
    nixcode = "code ${config.home.homeDirectory}/nixos/"; # hardcoded editor-launch command
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
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
        dracula-theme.theme-dracula
        gruntfuggly.todo-tree
      ];
    };
  };
}
