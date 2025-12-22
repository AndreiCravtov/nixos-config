# Top-level configuration for everything in this repo.
#
# Values are set in 'config.nix' in repo root.
{lib, ...}: let
  hostName = lib.mkOption {
    type = lib.types.strMatching "^$|^[[:alnum:]]([[:alnum:]_-]{0,61}[[:alnum:]])?$";
    description = ''
      The name of the machine. It corresponds to the active NisOS configuration
      under `/configurations/nixos/<HOSTNAME>/default.nix`.

      The hostname must be a valid DNS label (see RFC 1035 section 2.3.1:
      "Preferred name syntax", RFC 1123 section 2.1: "Host Names and Numbers")
      and as such must not contain the domain part. Thisp means that the hostname
      must start with a letter or digit, end with a letter or digit, and have
      as interior characters only letters, digits, and hyhen. The maximum
      length is 63 characters. Additionally it is recommended to only use
      lower-case characters.

      WARNING: Do not use underscores (_) or you may run into unexpected issues.
    '';
  };
  username = lib.mkOption {
    type = lib.types.str;
    description = ''
      The username of the main user. It corresponds to the active Home Manager
      configuration under `/configurations/home/<USERNAME>.nix`.
    '';
  };
  userDescription = lib.mkOption {
    type = lib.types.passwdEntry lib.types.str;
    description = ''
      A short description of the user account, typically the
      user's full name.  This is actually the “GECOS” or “comment”
      field in {file}`/etc/passwd`.
    '';
  };
  gitFullName = lib.mkOption {
    type = lib.types.str;
    description = ''
      Full name of the user, for Git purposes.
    '';
  };
  gitEmail = lib.mkOption {
    type = lib.types.str;
    description = ''
      E-mail of the user, for Git purposes.
    '';
  };
  sshKey = lib.mkOption {
    type = lib.types.str;
    description = ''
      SSH public key
    '';
  };
in {
  imports = [
    ../../config.nix
  ];
  options = {
    me = lib.mkOption {
      description = "Top-level configuration for everything in this repo.";
      type = lib.types.submodule {
        options = {
          hostName = hostName;
          username = username;
          userDescription = userDescription;
          gitFullName = gitFullName;
          gitEmail = gitEmail;
          sshKey = sshKey;
        };
      };
    };
  };
}
