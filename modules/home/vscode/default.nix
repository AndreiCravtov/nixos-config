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

        "git.autofetch" = true;
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
        gruntfuggly.todo-tree
        streetsidesoftware.code-spell-checker
        antfu.browse-lite
        fill-labs.dependi
        mkhl.direnv
        usernamehw.errorlens
        tomoki1207.pdf

        # Git # TODO: break out into its own thing ??
        mhutchie.git-graph
        codezombiech.gitignore
        github.vscode-pull-request-github
        waderyan.gitblame

        # language support
        myriad-dreamin.tinymist
        tamasfe.even-better-toml
        leanprover.lean4
        yzhang.markdown-all-in-one
        noir-lang.vscode-noir
        ocamllabs.ocaml-platform
        jebbs.plantuml
        arthurwang.vsc-prolog
        treborhuang.vscode-forester
        redhat.vscode-xml
        redhat.vscode-yaml
        golang.go # TODO: break out into its own thing ??
      ];
    };
  };
}
