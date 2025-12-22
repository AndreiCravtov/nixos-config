{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.homeModules.default
  ];

  # Defined by /modules/home/me.nix
  # And used all around in /modules/home/*
  me = {
    username = "royalguard";
    fullname = "Andrei Cravtov"; # TODO: make distinction between my full name for GIT purposes & for `Dr. Faust` purposes
    email = "johndoe@framework13.com";
  };

  home.stateVersion = "24.11";
}
