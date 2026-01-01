{
  flake,
  pkgs,
  ...
}: let
  inherit (flake.inputs) nix-jetbrains-plugins;
  inherit (pkgs.stdenv.hostPlatform) system;

  mkJetbrains = nix-jetbrains-plugins.lib."${system}".buildIdeWithPlugins pkgs.jetbrains;
in {
  # TODO: flesh out more!!
  home.packages = [
    # Adds the latest IDEA version with the latest compatible version of "com.intellij.plugins.watcher".
    (mkJetbrains "idea" ["com.intellij.plugins.watcher"])
    (mkJetbrains "clion" ["com.intellij.plugins.watcher"])
    (mkJetbrains "rust-rover" ["com.intellij.plugins.watcher"])
    (mkJetbrains "pycharm" ["com.intellij.plugins.watcher"])
  ];
}
