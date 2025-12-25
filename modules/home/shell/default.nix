{
  flake,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (flake.config.flake) my-util;
in {
  # A module that automatically imports everything else in the parent folder.
  # NOTE: cannot use `my-util.readDirPaths` due to recursion!!
  imports = my-util.readDirPaths {readPath = ./.;};

  # Enable all possible shell integrations
  home.shell.enableShellIntegration = true;

  # We all need some Bash in our lives :)
  programs.bash.enable = true;

  # Better UNIX shell commands
  home.shellAliases = {
    # cd = "z"; # This feels wrong...
    tree = "eza --tree";
    grep = "rg -uuu";
  };
  home.packages = with pkgs; [
    sd # Better `sed`
  ];
  programs = {
    zoxide.enable = true; # Better `cd`
    eza = {
      enable = true; # Better `ls` (and `tree` if configured)
      icons = "always";
      colors = "always";
      git = true;
      extraOptions = ["--group-directories-first" "--header"];
    };
    ripgrep.enable = true; # Better `grep`
    fd.enable = true; # Better `find`
    jq.enable = true; # `sed` for JSON data
  };

  # Making working with the shell nicer
  programs = {
    pay-respects.enable = true;
    fzf = {
      enable = true; # Type `<ctrl> + r` to fuzzy search your shell history
      # TODO: further config ?? themes ?? settings ??
    };
  };

  programs = {
    # Better shell prompt!
    starship = {
      enable = true;
      enableBashIntegration = false; # bash doesn't work well with this
      settings = {
        add_newline = false;
        username = {
          style_user = "blue bold";
          style_root = "red bold";
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };
        hostname = {
          ssh_only = false;
          ssh_symbol = "🌐 ";
          format = "on [$hostname](bold red) ";
          trim_at = ".local";
          disabled = false;
        };
      };
    };
  };
}
