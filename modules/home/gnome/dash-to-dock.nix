{
  pkgs,
  lib,
  config,
  ...
}: {
  # Install required dependencies
  home.packages = with pkgs; [gnomeExtensions.dash-to-dock];

  # Configure dconf settings
  dconf.settings = {
    "org/gnome/shell".enabled-extensions = ["dash-to-dock@micxgx.gmail.com"];

    "org/gnome/shell/extensions/dash-to-dock" = {
      dash-max-icon-size = 64;
      show-trash = false;
      show-mounts = false;
      click-action = "launch";
      scroll-action = "cycle-windows";
      background-opacity = 0.15;
    };
  };
}
