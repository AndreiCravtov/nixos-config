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
    #yelp # Help view - I actually needed it for something LOL
    gnome-characters # Utility to help find unusual charaters
    gnome-contacts
    epiphany # Web browser
    geary # Email reader
    gnome-console # Replaced with `kitty`
  ];

  # Enable GNOME configurability and apps
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    gjs # Some extensions may need this

    gnome-tweaks
    gnome-software
    appeditor
  ];

  # GNOME nautilus extensions
  programs.nautilus-open-any-terminal.enable = true;
}
