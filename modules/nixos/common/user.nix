# Check that the configuration for user specified in (root) config.nix exists in
# the /configurations/home and apply appropriate settings.
{
  flake,
  lib,
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
  # Set up user description & user-groups
  users.users.${ensureConfigExists username} = {
    isNormalUser = true;
    description = lib.mkForce userDescription;
    extraGroups = ["networkmanager" "wheel"];
  };

  # Enable home-manager for our user
  home-manager.users.${username} = {
    imports = [(self + /configurations/home/${username}.nix)];
  };

  # All users can add Nix caches (will merge with other values set elsewhere).
  nix.settings.trusted-users = [username];
}
