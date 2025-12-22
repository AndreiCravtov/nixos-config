{
  flake,
  lib,
  config,
  ...
}: {
  # Make sure ssh-agent is running
  services.ssh-agent = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  # Declare `~/.ssh/config` declaratively via matchBlocks
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      # TODO: theres GOTTA be a better way to do this, look into [agenix](https://github.com/ryantm/agenix) maybe??
      "*" = {
        addKeysToAgent = "yes";
        identityFile = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
      };

      # TODO: figure out how to make `cloudflared` work on NixOS
      #"s11.exolabs.sh" = {
      #  proxyCommand = "/usr/local/sbin/cloudflared access ssh --hostname %h";
      #  user = "s11@s11.exolabs.sh";
      #};
    };
  };
}
