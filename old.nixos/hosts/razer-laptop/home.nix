{
  config,
  pkgs,
  inputs,
  ...
}:
let
in
{
  imports = [
    ./../../modules/home-manager/kitty.nix
  ];

  kitty.enable = true; # Enable kitty configuration

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "johndoe";
  home.homeDirectory = "/home/johndoe";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # This adds flake paths to nix path...???
  #nix.nixPath = ["nixpkgs=flake:nixpkgs"];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    nil
    nixd
    nixfmt-rfc-style
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

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Andrei Cravtov";
    userEmail = "the.andrei.cravtov@gmail.com";
  };

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
    # home manager needs to modify .zshrc
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # initial shell run stuff
    initContent = ''
      # p10k instant prompt
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';

    shellAliases = {
      ll = "ls -l";
    };
    history.size = 10000;
    history.ignoreAllDups = true;

    zplug = {
      # Extension management
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/johndoe/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
