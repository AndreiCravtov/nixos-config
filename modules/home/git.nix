{flake, ...}: let
  inherit (flake) config;
in {
  home.shellAliases = {
    g = "git";
    lg = "lazygit";
  };

  # https://nixos.asia/en/git
  programs = {
    git = {
      enable = true;
      ignores = ["*~" "*.swp"];

      settings = {
        user = {
          name = config.me.gitFullName;
          email = config.me.gitEmail;
        };
        alias = {
          # ci = "commit";
        };
        # init.defaultBranch = "master";
        # pull.rebase = "false";
      };
    };
    lazygit.enable = true;
  };
}
