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

  programs.zsh = {
    enable = true;

    # home manager needs to modify .zshrc
    enableCompletion = true; # TODO: replace with fzf-tab??
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
      {
        name = "history-substring-search";
        src = ohmyzshPluginSrc "history-substring-search";
      }

      # fuzzy-find tab completion
      # FIXME: fzf's zshell integration seems to be clashing with this plugin??
      # TODO: integrage with tmux + configure + have the nice preview thingy
      # TODO: does this supplant other things???
      #       e.g. completion/autosuggestion/etc??
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
        src = ohmyzshPluginSrc "magic-enter";
      }

      # Git aliases
      (lib.mkIf programs.git.enable {
        name = "git";
        src = ohmyzshPluginSrc "git";
      })
    ];

    initContent = lib.mkMerge [
      # Configure keybindings to enable navigation
      (lib.mkAfter (builtins.readFile ./key-bindings.zsh))

      (lib.mkAfter ''
        # Configure `magic-enter` to use aliases so that `you-should-use` does not complain erroneously
        MAGIC_ENTER_GIT_COMMAND="gst -u ."          # `git status` => `gst`
        MAGIC_ENTER_JJ_COMMAND="jj st --no-pager ." # NONE
        MAGIC_ENTER_OTHER_COMMAND="lsd -lh ."       # NONE
      '')
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
