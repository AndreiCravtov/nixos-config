{
  flake,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (flake.config.flake) my-util;

  ohmyzshRepoSrc = pkgs.fetchFromGitHub {
    owner = "ohmyzsh";
    repo = "ohmyzsh";
    rev = "0f45f82c0afdcaf71b193e349d01c069a3fb9de7";
    sha256 = "sha256-cu+QEDG/Wt3PYt1w5DQMH0DU2/JdwXKU974gG65XAaY=";
  };
  ohmyzshPluginSrc = name: "${ohmyzshRepoSrc}/plugins/${name}";
in {
  # A module that automatically imports everything else in the parent folder.
  # NOTE: cannot use `my-util.readDirPaths` due to recursion!!
  imports = my-util.readDirPaths {readPath = ./.;};

  # Dependencies
  programs.fzf.enable = true;
  programs.eza.enable = true;

  # Configuration
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = ["brackets"];
    };
    autosuggestion = {
      enable = true;
      strategy = ["history" "completion"];
    };
    history = {
      size = 20000;
    };

    plugins = with config; [
      # Better up/down-arrow history
      # TODO: swap for `fzf-history-widget`
      {
        name = "history-substring-search";
        src = ohmyzshPluginSrc "history-substring-search";
      }

      # fuzzy-find tab completion
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }

      # Remind me of aliases
      {
        name = "you-should-use";
        src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
      }

      # Empty-enter executes default commands
      {
        name = "magic-enter";
        src = ./.;
      }

      # Git aliases
      (lib.mkIf programs.git.enable {
        name = "git";
        src = ohmyzshPluginSrc "git";
      })
    ];

    initContent = with builtins;
      lib.mkMerge [
        # Configure keybindings to enable navigation
        (lib.mkAfter (readFile ./key-bindings.zsh))

        # Configure `fzf-tab` plugin
        (lib.mkAfter (readFile ./fzf-tab.zsh))
      ];

    # antidote plugins
    # antidote = {
    #   enable = true;
    #   plugins = lib.mkMerge (with config.programs; [
    #     [
    #       # OhMyZsh framework integration
    #       # TODO: most of these plugins shouldn't need OhMyZsh
    #       #       -> custom keybindings (or setting env variables like PAGER/MANPAGER??
    #
    #       ''
    #     ]
    #     # replace `cat` with `bat` & make `man` use `bat` too
    #     # TODO: make kitty use bat pager also?? `scrollback_pager` option
    #     (lib.mkIf bat.enable ["fdellwing/zsh-bat"])
    #   ]);
    # };
  };
}
