{pkgs, ...}: {
  # Install required dependencies
  home.packages = with pkgs; [gnomeExtensions.clipboard-indicator];

  # Configure dconf settings
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "clipboard-indicator@tudmotu.com"
      ];
    };
    "org/gnome/shell/extensions/clipboard-indicator" = {
      clear-history-on-interval = true;
      clear-history-interval = 5;
    };
  };
}
