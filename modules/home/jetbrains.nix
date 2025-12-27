{
  flake,
  pkgs,
  ...
}: let
  inherit (flake.inputs) nix-jetbrains-plugins;
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  # TODO: flesh out more!!
  home.packages = with nix-jetbrains-plugins.lib."${system}"; [
    # Adds the latest IDEA version with the latest compatible version of "com.intellij.plugins.watcher".
    (buildIdeWithPlugins pkgs.jetbrains "idea-ultimate" ["com.intellij.plugins.watcher"])
    (buildIdeWithPlugins pkgs.jetbrains "clion" ["com.intellij.plugins.watcher"])
    (buildIdeWithPlugins pkgs.jetbrains "rust-rover" ["com.intellij.plugins.watcher"])
    (buildIdeWithPlugins pkgs.jetbrains "pycharm-professional" ["com.intellij.plugins.watcher"])
  ];
}
