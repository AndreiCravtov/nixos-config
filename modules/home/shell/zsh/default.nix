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
      # remind me of aliases
      {
        name = "you-should-use";
        src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
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

      {
        name = "history-substring-search";
        src = ohmyzshPluginSrc "history-substring-search";
      }

      # Git integration
      (lib.mkIf programs.git.enable {
        name = "git";
        src = ohmyzshPluginSrc "git";
      })
    ];

    # antidote plugins
    # antidote = {
    #   enable = true;
    #   plugins = lib.mkMerge (with config.programs; [
    #     [
    #       # OhMyZsh framework integration
    #       # TODO: most of these plugins shouldn't need OhMyZsh
    #       #       -> custom keybindings (or setting env variables like PAGER/MANPAGER??)
    #       ''
    #         ohmyzsh/ohmyzsh path:lib/key-bindings.zsh             # allows for CTRL+L/R navigation
    #         ohmyzsh/ohmyzsh path:plugins/history-substring-search # better up-arrow history search

    #         # FIXME: right now the default commangs causes `zsh-you-should-use` to complain;
    #         #        alter the defaults to use the aliases instead :)
    #         ohmyzsh/ohmyzsh path:plugins/magic-enter              # empty-enter executes default commands
    #       ''
    #     ]
    #     (lib.mkIf git.enable ["ohmyzsh/ohmyzsh path:plugins/git"]) # git aliases

    #     # replace `cat` with `bat` & make `man` use `bat` too
    #     # TODO: make kitty use bat pager also?? `scrollback_pager` option
    #     (lib.mkIf bat.enable ["fdellwing/zsh-bat"])
    #   ]);
    # };
  };
}
