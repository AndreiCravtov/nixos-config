{
  flake,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (flake.config.flake) my-util;
in {
  # A module that automatically imports everything else in the parent folder.
  # NOTE: cannot use `my-util.readDirPaths` due to recursion!!
  imports = my-util.readDirPaths {readPath = ./.;};

  home.shellAliases = {
    dconf-watch = "dconf watch /"; # Watch `dconf` settings change
  };

  # List of extensions to enable
  home.packages = with pkgs.gnomeExtensions; [
    # common dependencies needed by extensions
    pkgs.gjs

    # extensions
    clipboard-history
    color-picker
    # desktop-icons-ng-ding
    gnome-she
    gtk4-desktop-icons-ng-ding
    appindicator
    launch-new-instance
    power-off-options
  ];

  # Configure dconf settings
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "color-picker@tuberry"
        "appindicatorsupport@rgcjonas.gmail.com"
        "power-off-options@axelitama.github.io"
        "clipboard-history@alexsaveau.dev"
        # "ding@rastersoft.com"
        "gtk4-ding@smedius.gitlab.com"
      ];
    };
  };
}
