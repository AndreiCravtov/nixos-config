{
  flake,
  pkgs,
  lib,
  ...
}: let
  clearVisionV7 = {
    name = "ClearVision-v7";
    text = builtins.readFile ./theme.css;
  };
in {
  imports = [flake.inputs.nixcord.homeModules.nixcord];

  programs.nixcord = {
    enable = true;

    # enables Equibop/Equicord
    discord.enable = false;
    equibop.enable = true;
    openASAR.enable = true;

    # config Equibop
    quickCss = "";
    config = {
      useQuickCss = true;

      # theming/style config
      themes."${clearVisionV7.name}" = clearVisionV7.text;
      enabledThemes = ["${clearVisionV7.name}.css"];
      frameless = true;
      transparent = true;

      # default plugins
      plugins = {
        crashHandler.enable = true;
        webKeybinds.enable = true;
        webScreenShareFixes.enable = true;
      };
    };

    # custom plugins not included
    # NOTE: needs to be configured via JSON in extraConfig
    userPlugins = {
      # someCoolPlugin = "github:someUser/someCoolPlugin/someHashHere";
    };
  };
}
