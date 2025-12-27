{
  config,
  lib,
  pkgs,
  ...
}: {
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
  };
}
