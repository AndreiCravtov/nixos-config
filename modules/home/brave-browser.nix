{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {
        # ColorPick Eyedropper: https://chromewebstore.google.com/detail/colorpick-eyedropper/ohcpnigalekghcmgcdcenkpelffpdolg
        id = "ohcpnigalekghcmgcdcenkpelffpdolg";
      }
    ];
    dictionaries = with pkgs; [
      hunspellDictsChromium.en_US
      hunspellDictsChromium.en_GB
    ];
    commandLineArgs = [
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
    ];
  };
}
