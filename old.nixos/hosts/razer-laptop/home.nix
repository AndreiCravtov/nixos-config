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

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    #enableFishIntegration= true;
    #enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    #enableFishIntegration= true;
    #enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  programs.bash.enable = true; # home manager needs to modify .bashrc

  programs.zsh = {
    shellAliases = {
      ll = "ls -l";
    };

    zplug = {
      # Extension management
      enable = true;
      plugins = [
        {
          name = "romkatv/powerlevel10k";
          tags = [
            "as:theme"
            "depth:1"
          ];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
  };
}
