{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.laptop.disable-internal-kbd;

  # Program binaries
  blockKbd = "block-internal-kbd";
  systemctl = lib.getExe' pkgs.systemd "systemctl";
  notify-send = lib.getExe' pkgs.libnotify "notify-send";
  evtest = lib.getExe' pkgs.evtest "evtest";
  toggleScript = lib.getExe (pkgs.writeShellScriptBin "toggle-internal-kbd" ''
    set -eu
    unit="${blockKbd}.service"

    if ${systemctl} is-active --quiet "$unit"; then
      ${systemctl} stop "$unit"
      ${notify-send} "Internal keyboard" "ENABLED"
    else
      ${systemctl} start "$unit"
      ${notify-send} "Internal keyboard" "DISABLED"
    fi
  '');

  toggleDesktop = pkgs.makeDesktopItem {
    name = "toggle-internal-kbd";
    desktopName = "Toggle Internal Keyboard";
    comment = "Enable/disable the built-in keyboard";
    exec = "${toggleScript}";
    icon = "input-keyboard";
    terminal = false;
    categories = ["System" "Settings"];
    type = "Application";
  };

  enableDesktop = pkgs.makeDesktopItem {
    name = "enable-internal-kbd";
    desktopName = "Enable Internal Keyboard";
    comment = "Re-enable the built-in keyboard";
    exec = "${systemctl} stop ${blockKbd}.service";
    icon = "input-keyboard";
    terminal = false;
    categories = ["System" "Settings"];
    type = "Application";
  };

  stopCommand = ''
    ${systemctl} stop ${blockKbd}.service || true
  '';
in {
  options = {
    laptop.disable-internal-kbd = {
      enable = lib.mkEnableOption "a way to disable your native keyboard";
      internalKbd = lib.mkOption {
        example = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        description = "The path to your internal keyboard. To identify it, run `ls -l /dev/input/by-path/ | grep -i kbd`.";
        type = lib.types.path;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    # Packages: evtest does the grab, libnotify gives notifications, plus the desktop items/scripts
    environment.systemPackages = [
      toggleDesktop
      enableDesktop
    ];

    # Service: blocks internal keyboard by grabbing its evdev device
    systemd.services.${blockKbd} = {
      description = "Block internal keyboard (evtest --grab)";
      wantedBy = []; # not started automatically
      serviceConfig = {
        Type = "simple";
        ExecStart = "${evtest} --grab ${cfg.internalKbd}";
        Restart = "on-failure";
        StandardOutput = "null";
        StandardError = "null";
      };
    };

    # Polkit: allow wheel users to manage ONLY this one unit without auth prompts
    security.polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (action.id == "org.freedesktop.systemd1.manage-units" &&
              action.lookup("unit") == "${blockKbd}.service" &&
              subject.isInGroup("wheel")) {

            var verb = action.lookup("verb");
            if (verb == "start" || verb == "stop" || verb == "restart") {
              return polkit.Result.YES;
            }
          }
        });
      '';
    };

    # Make sure to re-enable on suspend/sleep/etc.
    powerManagement = {
      enable = true;
      powerDownCommands = stopCommand;
      powerUpCommands = stopCommand;
      resumeCommands = stopCommand;
    };

    assertions = [
      {
        assertion = config.services.dbus.enable;
        message = "disable-internal-kbd: requires services.dbus.enable = true (systemctl/polkit needs D-Bus).";
      }
      {
        assertion = config.security.polkit.enable;
        message = "disable-internal-kbd: requires security.polkit.enable = true (non-root wheel user needs to be able to toggle).";
      }
      {
        assertion = config.powerManagement.enable;
        message = "disable-internal-kbd: requires powerManagement.enable = true (keyboard only remains disabled while logged in).";
      }
    ];
  };
}
