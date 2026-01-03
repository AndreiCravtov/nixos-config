{pkgs, ...}: {
  # Config
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace-release; [
      # TODO: some of these are possibly overlapping eachother's jobs
      ms-azuretools.vscode-containers
      ms-vscode-remote.remote-containers
      docker.docker
      jeff-hykin.better-dockerfile-syntax
      exiasr.hadolint
    ];
  };

  # Dependencies
  home.packages = with pkgs; [
    hadolint
  ];
}
