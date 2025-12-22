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
      userName = config.me.gitFullName;
      userEmail = config.me.gitEmail;
      ignores = ["*~" "*.swp"];
      aliases = {
        ci = "commit";
      };
      extraConfig = {
        # init.defaultBranch = "master";
        # pull.rebase = "false";
      };
    };
    lazygit.enable = true;
  };
}
