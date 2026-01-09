{pkgs, ...}: {
  # Install required dependencies
  home.packages = with pkgs; [gnomeExtensions.appindicator];

  # Configure dconf settings
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
      ];
    };
    "org/gnome/shell/extensions/appindicator" = {
      "tray-pos" = "left";
    };
  };
}
