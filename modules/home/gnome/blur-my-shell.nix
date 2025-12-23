{pkgs, ...}: {
  # Install required dependencies
  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell
  ];

  # Configure dconf settings
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "blur-my-shell@aunetx"
      ];
    };
    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      opacity = 255;
      dynamic-opacity = false;
      blur-on-overview = true;

      # TODO: condition on kitty being enabled!!!?? or perhaps even invert and add to kitty configs???
      whitelist = [
        "kitty"
        # TODO: add `vesktop` after vesktop has been configured too!!
      ];
    };
  };
}
