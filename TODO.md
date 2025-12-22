# A list of TODOs
 - continue propogating the config.nix stuff across the repo & purge any __redundant__/double configuration
   e.g. "myusers" in nixos modules configs & "me" in home modules!!
 - + also set up git finally!!
 - make the my-utils thing accessible NICER than it is right now!!! (make use of submodules more??)
   OBSERVE how config.nix in handled!!!
 - continue fixing nixd!! => right now it has access to the overlays, but the overlays are instantiated TWICE!!!
 - + once in toplevel (flake pkgs) and once in nix.nix (nixos) => figure out which one of those it makes sense to use!!
 - + also the flakes options (non-perSystem) are just not working very well... => make work
 - there is a bunch of duplicate user-handling logic happening!!
 - address the WARNINGS!!!
 - make a `packages` overlay that simply overlays any packages in the `/packages` folder
   (see nixos-config example for this) + minimal "my hello" package or something (to test)...

## Partially DONE
 - figure out a nicer way to access `root` special arg w/out reaching to `.debug` symbols everywhere
 - + FIGURED IT OUT => `flake.inputs.self + /.` will get the root dir
 - + TODO: a way to maybe expose this ergonomically?? maybe via my-utils or something??