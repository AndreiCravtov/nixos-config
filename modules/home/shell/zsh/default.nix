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
  programs.zoxide.enable = true;

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
      {
        name = "history-substring-search";
        src = ohmyzshPluginSrc "history-substring-search";
      }

      # fuzzy-find tab completion
      # FIXME: right now SOMETIMES the tabbing doesn't get hijacked
      #        there must be something ELSE that is tab-completing FIRST???
      #        [Docs](https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#compatibility-with-other-plugins)
      #        mention that fzf-tab should be LAST in plugin list...
      #        perhaps `enableCompletion` is latching to `^I` **after** fzf-tab
      #        which causes those issues??
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
  };
}
