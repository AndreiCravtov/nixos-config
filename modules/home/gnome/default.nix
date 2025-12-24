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

  # List of extensions to install
  home.packages = with pkgs.gnomeExtensions; [
    clipboard-history
    color-picker
    appindicator
    launch-new-instance
    power-off-options
  ];

  dconf.settings = with lib.hm.gvariant; {
    # GNOME settings app
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/mutter" = {
      workspaces-only-on-primary = false;
      experimental-features = [
        "scale-monitor-framebuffer" # Allows fractional scaling
      ];
    };
    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple ["xkb" "gb"])
        (mkTuple ["xkb" "us"])
      ];
      xkb-options = ["compose:rwin"];
    };

    # Enable GNOME extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "color-picker@tuberry"
        "appindicatorsupport@rgcjonas.gmail.com"
        "power-off-options@axelitama.github.io"
        "clipboard-history@alexsaveau.dev"
      ];
    };

    # GNOME nautilus settings
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
  };
}
