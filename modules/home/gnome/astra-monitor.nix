{
  pkgs,
  lib,
  ...
}: {
  # Install required dependencies
  home.packages = with pkgs; [
    nethogs
    iotop
    pciutils
    iw
    libgtop
    gtop
    gnomeExtensions.astra-monitor
  ];

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

  # SEE: https://github.com/fflewddur/tophat/issues/106#issuecomment-1848319826
  systemd.user.sessionVariables = {
    GI_TYPELIB_PATH = pkgs.libgtop + "/lib/girepository-1.0/";
  };
}
