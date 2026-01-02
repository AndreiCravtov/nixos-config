{pkgs, ...}: let
  gimp = pkgs.gimp3-with-plugins.override {
    plugins = with pkgs.gimp3Plugins; [
      gmic
      # resynthesizer # TODO: add -> not avalaible yet
      # bimp # FIXME: this causes build issues ??
    ];
  };
in {
  home.packages = [gimp];
}
