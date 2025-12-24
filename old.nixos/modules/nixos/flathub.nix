{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    flathub.enable = lib.mkEnableOption "Enables my Flathub configuration module";
  };

  config = lib.mkIf config.flathub.enable {
    # Required to install flatpak
    xdg.portal = {
      enable = true;
      config = {
        common = {
          default = [
            "gtk"
          ];
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        #      xdg-desktop-portal-kde
        #      xdg-desktop-portal-wlr
      ];
    };

    # install flatpak binary
    services.flatpak = {
      enable = true;

      # Add a new remote. Keep the default one (flathub)
      remotes = lib.mkOptionDefault [
        {
          name = "flathub-beta";
          location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }
      ];

      update.auto.enable = false;
      uninstallUnmanaged = false;

      # Add here the flatpaks you want to install
      packages = [
        "org.vinegarhq.Sober"
        "org.localsend.localsend_app"
        #{ appId = "com.brave.Browser"; origin = "flathub"; }
        #"com.obsproject.Studio"
        #"im.riot.Riot"
      ];
    };
  };
}
