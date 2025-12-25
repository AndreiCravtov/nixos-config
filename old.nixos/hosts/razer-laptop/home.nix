{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    obsidian
    jetbrains-toolbox # jetbrains-toolbox
    signal-desktop
    rust-analyzer
    telegram-desktop
    neofetch
    slack
    inkscape

    (python313.withPackages (ppkgs: [
      ppkgs.numpy
    ]))

    (ruby.withPackages (ps: [
      ]))

    # GNOME extensions
    gnomeExtensions.astra-monitor
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gtk4-desktop-icons-ng-ding
    gjs # needed for gtk4-desktop-icons-ng-ding
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    #enableFishIntegration= true;
    #enableNushellIntegration = true;
    enableZshIntegration = true;
  };
}
