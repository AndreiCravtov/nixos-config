# This is your nixos configuration.
# For home configuration, see /modules/home/*
{
  flake,
  lib,
  pkgs,
  ...
}: {
  # A module that automatically imports everything else in the parent folder.
  # NOTE: cannot use `my-util.readDirPaths` due to recursion!!
  imports = flake.config.flake.my-util.readDirPaths {readPath = ./.;};

  # Disable documentation app
  documentation.doc.enable = false;

  services = {
    # Enable SSH systemwide
    openssh.enable = true;
  };

  programs = {
    localsend.enable = true;

    # Dynamically linked libraries for unpackaged software
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        ## Put here any library that is required when running a package
        ## ...
        ## Uncomment if you want to use the libraries provided by default in the steam distribution
        ## but this is quite far from being exhaustive
        ## https://github.com/NixOS/nixpkgs/issues/354513
        # (pkgs.runCommand "steamrun-lib" {} "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
      ];
    };
  };

  # Systemwide packages to install
  environment.systemPackages = with pkgs; [
    evtest
    usbutils
    lshw
    wget
    openssl
    pkg-config
    gnumake
    gcc
    clang
  ];

  # Apply systemwide security hardening
  security = lib.optionalAttrs pkgs.stdenv.isLinux {
    sudo.execWheelOnly = true;
  };

  # System-wide environment variables
  environment.variables = {
    SYSTEMD_LESS = "FRXMK"; # Make systemd pager wrap
  };
}
