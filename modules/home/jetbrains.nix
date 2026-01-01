{
  flake,
  pkgs,
  ...
}: let
  inherit (flake.inputs) nix-jetbrains-plugins;
  inherit (pkgs.stdenv.hostPlatform) system;

  mkJetbrains = nix-jetbrains-plugins.lib."${system}".buildIdeWithPlugins pkgs.jetbrains;

  commonPlugins = [
    "com.intellij.plugins.watcher"
    "com.sburlyaev.terminal.plugin"
  ];
in {
  # TODO: flesh out more!!
  home.packages = [
    (mkJetbrains "idea" commonPlugins)
    (mkJetbrains "clion" commonPlugins)
    (mkJetbrains "rust-rover" commonPlugins)
    (mkJetbrains "pycharm" commonPlugins)
  ];
}
