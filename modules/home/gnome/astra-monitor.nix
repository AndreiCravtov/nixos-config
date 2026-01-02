{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) types mkIf mkOption;
  cfg = config.gnome.extensions.astra-monitor;
in {
  options = {
    gnome.extensions.astra-monitor = {
      # TODO: change to mkEnableOption ??
      enable = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether to enable the Astra Monitor extension on Gnome.
        '';
      };

      enableAmdgpu = mkOption {
        type = types.bool;
        default = true; # TODO: maybe in the future, add more sophisticated detection??
        description = ''
          Whether to enable `amdgpu` integration for this extension.
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    # Install required dependencies
    home.packages = with pkgs; (lib.mkMerge [
      [
        gnomeExtensions.astra-monitor

        # dependencies
        pciutils
        nethogs
        iw
        iotop
        #libgtop # TODO: is this even needed??
      ]
      (mkIf cfg.enableAmdgpu [amdgpu_top])
    ]);

    # Configure dconf settings
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [
          "monitor@astraext.github.io"
        ];
      };
      "org/gnome/shell/extensions/astra-monitor" = {
        gpu-header-show = true;
        memory-header-tooltip-free = true;
        storage-header-tooltip-value = true;
        sensors-header-show = true;
      };
    };
  };
}
