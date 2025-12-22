# A module that automatically imports everything else in the parent folder.
# NOTE: cannot use `my-util.readDirPaths` due to recursion!!
{flake, ...}: {
  imports = flake.config.flake.my-util.readDirPaths {readPath = ./.;};
}
