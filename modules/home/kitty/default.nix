{
  flake,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (flake.config.flake) my-util;
  kittyIcons = "${pkgs.fetchFromGitHub {
    owner = "k0nserv";
    repo = "kitty-icon";
    rev = "7f631a61bcbdfb268cdf1c97992a5c077beec9d6";
    sha256 = "sha256-AXU1KOXaEiAMTkgkR+yVc8g4FZq8TqXj9imswCHhNKc=";
  }}/kitty.iconset";
in {
  # Install custom Kitty Icons
  xdg.dataFile."icons/hicolor/16x16/apps/kitty.png".source = "${kittyIcons}/icon_16x16.png";
  xdg.dataFile."icons/hicolor/32x32/apps/kitty.png".source = "${kittyIcons}/icon_32x32.png";
  xdg.dataFile."icons/hicolor/128x128/apps/kitty.png".source = "${kittyIcons}/icon_128x128.png";
  xdg.dataFile."icons/hicolor/256x256/apps/kitty.png".source = "${kittyIcons}/icon_256x256.png";

  # Configure Kitty
  programs.kitty = {
    enable = true;

    # Integrations
    enableGitIntegration = config.programs.git.enable;

    # Local theme file must be included manually
    # (themeFile option only works for themes in `pkgs.kitty-themes`)
    # TODO: fix broken colors (e.g. some things are black when they should not be)
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
      # Layout settings: enable all layouts, tall by default
      enabled_layouts = lib.strings.concatStringsSep "," [
        "tall"
        "fat"
        "grid"
        "horizontal"
        "splits"
        "stack"
        "vertical"
      ];

      # Window display setting
      hide_window_decorations = "yes";
      background_opacity = 0.65;
      show_hyperlink_targets = "yes";
      cursor_trail = 1;

      # Tab bar style settings
      tab_bar_min_tabs = 1;
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}{sub.index}";

      # Scroll/bar display settings
      scrollback_lines = 100000;
      scrollbar = "scrolled";
      scrollbar_interactive = "yes";
      scrollbar_jump_on_click = "yes";
      scrollbar_width = 0.5;
      scrollbar_radius = 0.45; # less than scrollbar width
      scrollbar_hover_width = 0.75;
      scrollbar_gap = 0.2;
      scrollbar_handle_opacity = 0.35;

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

  # Make default XDG terminal
  # TODO: maybe gate behind "make default" option??
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = ["kitty.desktop"];
    };
  };

  # Make default GNOME nautilus terminal
  # TODO: maybe gate behind Gnome nautilus being installed??
  #       RN this config is (sort of) split across THIS file
  #       and the ./nixos/gui/gnome.nix one where the extension is enabled
  dconf.settings = {
    "com/github/stunkymonkey/nautilus-open-any-terminal" = {
      terminal = "kitty";
    };
  };
}
