{pkgs, ...}: let
  texlive =
    pkgs.texliveFull.withPackages (p: [
    ]);
in {
  home.packages = [texlive];
}
