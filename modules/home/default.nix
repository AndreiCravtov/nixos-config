{flake, ...}: let
  inherit (flake) config;
in {
  # A module that automatically imports everything else in the parent folder.
  # NOTE: cannot use `my-util.readDirPaths` due to recursion!!
  imports = config.flake.my-util.readDirPaths {readPath = ./.;};

  # Set username based on global config
  home.username = config.me.username;
}
