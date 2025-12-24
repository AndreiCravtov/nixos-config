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

  programs.kitty = {
    enable = true;

    # Integrations
    enableGitIntegration = config.programs.git.enable;
    shellIntegration = with config.programs; {
      # mode = "no-cursor";

      enableBashIntegration = bash.enable;
      enableZshIntegration = zsh.enable;
      enableFishIntegration = fish.enable;
    };

    # Local theme file must be included manually
    # (themeFile option only works for themes in `pkgs.kitty-themes`)
    extraConfig = ''
      include ${./current-theme.conf}
    '';
    # themeFile = "SpaceGray_Eighties";

    settings = {
      # scrollback_lines = 10000;
      # enable_audio_bell = false;
      # update_check_interval = 0;
    };

    # themeFile = "SpaceGray_Eighties";

    # font = ;

    actionAliases = {
      # "launch_tab" = "launch --cwd=current --type=tab";
      # "launch_window" = "launch --cwd=current --type=os-window";
    };

    keybindings = {
      # "ctrl+c" = "copy_or_interrupt";
      # "ctrl+f>2" = "set_font_size 20";
    };

    mouseBindings = {
      # "ctrl+left click" = "ungrabbed mouse_handle_click selection link prompt";
      # "left click" = "ungrabbed no-op";
    };

    environment = {
      # "LS_COLORS" = "1";
    };

    quickAccessTerminalConfig = {
      # start_as_hidden = false;
      # hide_on_focus_loss = false;
      # background_opacity = 0.85;
    };
  };
}
