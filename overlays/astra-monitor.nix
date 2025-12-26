# Patches astra-monitor to add GTop library path;
# SEE: https://github.com/NixOS/nixpkgs/blob/e981466fbb08e6231a1377539ff17fbba3270fda/pkgs/by-name/gn/gnome-shell-extensions/package.nix#L25-L32
# SEE: https://discourse.gnome.org/t/access-to-repository-configuration-from-language-bindings-with-girepository-3-0/31257/2
{...}: self: super: {
  gnomeExtensions =
    super.gnomeExtensions
    // {
      astra-monitor = super.gnomeExtensions.astra-monitor.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ [
            (super.replaceVars ./fix_astra-monitor_gtop.patch {
              gtop_path = "${super.libgtop}/lib/girepository-1.0";
            })
          ];
      });
    };
}
