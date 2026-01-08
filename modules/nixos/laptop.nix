# Configurations to enable (mostly about power) for laptop hosts
{
  flake,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.laptop;
in {
  imports = [
    flake.inputs.auto-cpufreq.nixosModules.default
  ];
  options = {
    laptop = {
      enable = lib.mkEnableOption "Laptop Mode";
      # TODO: not sure what else to call this LMAO
      #       probably will need to rename it or change its type
      #       or whatever
      enablePowerSaving = lib.mkOption {
        default = cfg.enable;
        example = false;
        description = "Whether to enable Power Saving for the laptop.";
        type = lib.types.bool;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.auto-cpufreq = {
      enable = cfg.enablePowerSaving;

      # SEE: https://github.com/AdnanHodzic/auto-cpufreq/blob/master/auto-cpufreq.conf-example
      settings = {
        charger = {
          governor = "performance";
          energy_performance_preference = "performance";
          platform_profile = "performance";
          turbo = "auto";
        };

        # this is for ignoring controllers and other connected devices battery from affecting
        # laptop preformence
        power_supply_ignore_list = {
          # name1 = this;
          # name2 = is;
          # name3 = an;
          # name4 = example;
        };

        battery = {
          # Specify which battery device to use for reading battery information. see available batteries by running: ls /sys/class/power_supply/
          # If not set, auto-cpufreq will automatically detect and use the first battery found
          # battery_device = "BAT1";

          governor = "powersave";
          energy_performance_preference = "power";
          platform_profile = "low-power";
          turbo = "auto";
        };
      };
    };

    # auto-cpufreq is incompatible with power-profiles-daemon
    services.power-profiles-daemon.enable = !cfg.enablePowerSaving;
  };
}
