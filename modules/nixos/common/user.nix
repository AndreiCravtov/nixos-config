# Check that the configuration for user specified in (root) config.nix exists in
# the /configurations/home and apply appropriate settings.
{
  flake,
  lib,
  pkgs,
  ...
}: let
  inherit (flake) inputs config;
  inherit (config.me) username userDescription;
  inherit (inputs) self;

  # Check that there is a corresponding Home-Manager configuration set up for this user.
  ensureConfigExists = with builtins;
  with lib; let
    regularFiles =
      filterAttrs (
        n: v:
          v
          == "regular"
          && strings.hasSuffix ".nix" n
      )
      (readDir (self + /configurations/home));
    baseNames = map (n: replaceStrings [".nix"] [""] n) (attrNames regularFiles);
  in
    config.flake.my-util.guardMsg
    (elem config.me.username baseNames)
    ''
      Ensure that there is a Home-Manager configuration that corresponds to
      the username `${config.me.username}` (specified in repo-root's config.nix).
    '';
in {
  # Enable ZSH systemwide
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Set up user description & user-groups, etc.
  users.users.${ensureConfigExists username} = {
    isNormalUser = true;
    description = lib.mkForce userDescription;
    extraGroups = ["networkmanager" "wheel"];
  };

  home-manager = {
    # Enable home-manager for our user
    users.${username} = {
      imports = [(self + /configurations/home/${username}.nix)];
    };

    # Expose options for user-defined HM modules
    sharedModules = [
      ({
        options,
        lib,
        ...
      }: {
        options.debug.options = lib.mkOption {
          default = options;
          defaultText = lib.literalExpression "options";
          internal = true;
          visible = false;
          readOnly = true;
        };
      })
    ];
  };

  # All users can add Nix caches (will merge with other values set elsewhere).
  nix.settings.trusted-users = [username];
}
