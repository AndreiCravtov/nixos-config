{
  flake,
  pkgs,
  ...
}: {
  imports = [
    flake.inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  # Add here the flatpaks you want to install
  services.flatpak.packages = [
    "org.vinegarhq.Sober"
    "org.localsend.localsend_app"
    #"com.obsproject.Studio"
    #"im.riot.Riot"
  ];

  # Flathub config
  services.flatpak = {
    enable = true;

    # Allow unmanaged apps
    uninstallUnmanaged = false;

    # Weekly updates
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };

    # Add a new remotes.
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];

    # Apply settings to apps
    overrides = {
      global = {
        # Force Wayland by default
        Context.sockets = ["wayland" "!x11" "!fallback-x11"];

        # TODO: correlate with HM Gnome settings??
        Environment = {
          # Fix un-themed cursor in some Wayland apps
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

          # Force correct theme for some GTK apps
          GTK_THEME = "Adwaita:dark";
        };
      };
    };
  };

  # # Required to install flatpak
  # xdg.portal = {
  #   enable = true;
  #   config = {
  #     common = {
  #       default = [
  #         "gtk"
  #       ];
  #     };
  #   };
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk
  #     #      xdg-desktop-portal-kde
  #     #      xdg-desktop-portal-wlr
  #   ];
  # };
}
