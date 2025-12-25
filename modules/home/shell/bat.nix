# Better `cat`
{pkgs, ...}: {
  home.shellAliases = {
    cat = "bat --paging=never";
    man = "batman";
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Monokai Extended Origin";
      pager = "builtin";
      map-syntax = [
        "*.jenkinsfile:Groovy"
        "*.props:Java Properties"
      ];
    };
    extraPackages = [pkgs.bat-extras.batman];
  };
}
