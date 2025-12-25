{pkgs, ...}: {
  imports = [
    ./gnome.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Exclude some (default) X11 apps
  services.xserver.excludePackages = [pkgs.xterm];

  # Wayland Ozone - makes chromium work
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
