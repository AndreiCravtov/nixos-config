# My own utility functions to use in this configuration.
# TODO: Make sure this works with nixd via inputs.self.my-util AND _module.args.my-util!!
#       ask chatgpt for help if doesn't work!!
#       Right now, have to consume with really ugly syntax: `flake.config.flake.my-util.readDirPaths`
#       as opposed to some easier way to consume...!!
{
  flake,
  lib,
  ...
}: let
  inherit (flake) config;
  ty = lib.types;
in {
  options.flake.my-util = {
    readDirPaths = lib.mkOption {
      description = "Read all paths in specified directory, except for the ones in the exclude-list.";
      type = ty.functionTo (ty.listOf ty.path);
      readOnly = true;
    };
  };
  config = {
    flake.my-util = {
      readDirPaths = {
        readPath,
        exclude ? ["default.nix"],
      }:
        with builtins; let
          entries = readDir readPath;
          wanted = lib.filterAttrs (n: v:
            v
            == "regular"
            && lib.strings.hasSuffix ".nix" n
            && !(elem n exclude))
          entries;
        in
          map (n: readPath + "/${n}") (attrNames wanted);
    };
  };
}
