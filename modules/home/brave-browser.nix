{
  pkgs,
  lib,
  config,
  ...
}: {
  # TODO: right now this doesn't let me install extensions at all!!
  #       >figure out how to migrate this config to use `brave/policies/managed/chrome-policies.json`
  #       >to force certain extensions to be installed + configure them, e.g. `vimium` or uBlock Origin
  programs.brave = {
    enable = true;
    dictionaries = with pkgs; [
      hunspellDictsChromium.en_US
      hunspellDictsChromium.en_GB
    ];
    commandLineArgs = [
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
    ];
  };
}
