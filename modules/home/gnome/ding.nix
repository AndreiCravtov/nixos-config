# TODO: this is utterly broken right now...!!
# SEE:  https://github.com/NixOS/nixpkgs/issues/274129
{pkgs, ...}: {
  # Install required dependencies
  home.packages = with pkgs; [
    gdk-pixbuf
    imagemagick # For converting jpg to png
    gnomeExtensions.gtk4-desktop-icons-ng-ding
  ];

  # Configure dconf settings
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "gtk4-ding@smedius.gitlab.com"
      ];
    };
  };
}
