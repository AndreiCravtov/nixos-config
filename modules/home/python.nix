{
  pkgs,
  lib,
  ...
}: let
  python3Pkg = pkgs.python3;
  python3 = python3Pkg.withPackages (p:
    with p; [
      numpy
      tkinter
    ]);
  python3Lib = "${python3}/lib/python${lib.versions.majorMinor python3Pkg.version}";
  idle3 = lib.getExe' python3 "idle3";
  idleIcons = "${python3Lib}/idlelib/Icons";
in {
  home.packages = [python3];

  # Install IDLE icons
  xdg.dataFile."icons/hicolor/16x16/apps/idle3.png".source = "${idleIcons}/idle_16.png";
  xdg.dataFile."icons/hicolor/32x32/apps/idle3.png".source = "${idleIcons}/idle_32.png";
  xdg.dataFile."icons/hicolor/48x48/apps/idle3.png".source = "${idleIcons}/idle_48.png";
  xdg.dataFile."icons/hicolor/256x256/apps/idle3.png".source = "${idleIcons}/idle_256.png";

  # Configure IDLE desktop entry
  xdg.desktopEntries.idle3 = {
    name = "IDLE 3";
    comment = "Python 3 Integrated Development and Learning Environment";
    exec = "${idle3} %F";
    settings.TryExec = idle3;
    terminal = false;
    type = "Application";
    icon = "idle3";
    categories = ["Development" "IDE"];
    mimeType = ["text/x-python"];
  };
}
