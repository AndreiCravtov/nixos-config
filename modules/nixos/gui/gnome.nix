{pkgs, ...}: {
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverridePackages = with pkgs; [
      # Expose nautilus GSettings to make some extensions work
      nautilus
    ];
  };

  # Exclude some (default) gnome apps
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-music
    gnome-calendar
    gnome-weather
    gnome-maps
    yelp # Help view
    gnome-characters # Utility to help find unusual charaters
    gnome-contacts
    epiphany # Web browser
    geary # Email reader
    # gnome-console TODO: disable this eventually (when kitty made default)
  ];

  # Enable gnome configurability and apps
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    # Some extensions may need this
    gjs

    gnome-tweaks
    appeditor
  ];
}
