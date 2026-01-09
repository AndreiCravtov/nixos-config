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
    launch-new-instance
    color-picker
    power-off-options
    status-area-horizontal-spacing
  ];

  dconf.settings = with lib.hm.gvariant; {
    # Enable GNOME extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "color-picker@tuberry"
        "power-off-options@axelitama.github.io"
        "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
      ];
    };

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

    # GNOME nautilus settings
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
  };
}
