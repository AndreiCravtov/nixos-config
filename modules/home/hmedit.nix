{
  pkgs,
  lib,
  config,
  ...
}: let
  files = builtins.toJSON config.home.file;
in {
  home.activation = {
    myActivationAction = builtins.trace files (lib.hm.dag.entryAfter ["writeBoundary"] ''
      echo "todo"
    '');
  };
}
