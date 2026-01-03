{pkgs, ...}: {
  # Config
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace-release; [
      rogalmic.bash-debug
      mads-hartmann.bash-ide-vscode
      jeff-hykin.better-shellscript-syntax
      formulahendry.code-runner
      ryu1kn.edit-with-shell
      meronz.manpages
      tetradresearch.vscode-h2o
      foxundermoon.shell-format
      timonwong.shellcheck
      remisa.shellman
      xshrim.txt-syntax
    ];
  };

  # Dependencies
  home.packages = with pkgs; [
    bashdb

    # TODO: these two are optional ??
    shellcheck
    shfmt
  ];
}
