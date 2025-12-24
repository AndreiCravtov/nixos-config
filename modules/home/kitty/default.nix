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

    # Set font => JetBrainsMono nerd font
    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
      size = 12;
    };

    actionAliases = {
      # Resize OS-window
      resize_os_window = "remote_control resize-os-window --self --incremental";
    };

    keybindings = {
      # Resize OS-window with arrow keys
      "super+ctrl+up" = "resize_os_window --height -1";
      "super+ctrl+down" = "resize_os_window --height 1";
      "super+ctrl+left" = "resize_os_window --width -1";
      "super+ctrl+right" = "resize_os_window --width 1";

      # Resize OS-window with Vim-like `JKL;`
      "super+ctrl+k" = "resize_os_window --height -1";
      "super+ctrl+l" = "resize_os_window --height 1";
      "super+ctrl+j" = "resize_os_window --width -1";
      "super+ctrl+;" = "resize_os_window --width 1";
    };

    mouseBindings = {
      # "ctrl+left click" = "ungrabbed mouse_handle_click selection link prompt";
      # "left click" = "ungrabbed no-op";
    };

    settings = {
      # Window setting
      hide_window_decorations = "yes";
      background_opacity = 0.65;
      show_hyperlink_targets = "yes";
      cursor_trail = 1;

      # Tab bar
      tab_bar_min_tabs = 1;
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}{sub.index}";

      # Scroll/bar
      scrollback_lines = 100000;
      scrollbar = "scrolled";
      scrollbar_interactive = "yes";
      scrollbar_jump_on_click = "yes";
      scrollbar_width = 0.75;
      scrollbar_hover_width = 1;

      # No updates
      update_check_interval = 0;
    };

    quickAccessTerminalConfig = {
      # start_as_hidden = false;
      # hide_on_focus_loss = false;
      # background_opacity = 0.85;
    };

    environment = {
      # "LS_COLORS" = "1";
    };
  };
}
