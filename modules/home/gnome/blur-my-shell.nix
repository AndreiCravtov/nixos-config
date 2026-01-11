{
  pkgs,
  lib,
  config,
  ...
}: {
  # Install required dependencies
  home.packages = with pkgs; [gnomeExtensions.blur-my-shell];

  # Configure dconf settings
  dconf.settings = {
    "org/gnome/shell".enabled-extensions = ["blur-my-shell@aunetx"];
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock".style-dash-to-dock = 1;
    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      opacity = 255;
      dynamic-opacity = false;
      blur-on-overview = true;

      # Add applications we want to blur
      whitelist = lib.mkMerge [
        (lib.mkIf config.programs.kitty.enable ["kitty"])
        (lib.mkIf config.programs.nixcord.equibop.enable ["equibop"])
      ];
    };
  };
}
