# A list of TODOs
 - make the my-utils thing accessible NICER than it is right now!!! (make use of submodules more??)
   OBSERVE how config.nix in handled!!!
 - address the WARNINGS!!!
 - make a `packages` overlay that simply overlays any packages in the `/packages` folder
   (see nixos-config example for this) + minimal "my hello" package or something (to test)...
 - set up windowing manager to support wayland + GNOME
 - break up `shell.nix` into OPTION GUARDED folder of modules, one file for each shell
 - + then dependencies on shell integration (e.g. `programs.nix-index.enableZshIntegration`)
     can be guarded behind a `mkIf config.zsh.enabled` or something like that ??

### System settings
 - gnome extensions
 - + suspend option
 - + blur & friends
 - default apps e.g. default browser = brave

### VSCode
 - rework the vscode structure to use a `default.nix` within folder rather than `vscode.nix`+`./vscode` combo
 - continue fixing nixd!! => right now it has access to the overlays, but the overlays are instantiated TWICE!!!
 - + once in toplevel (flake pkgs) and once in nix.nix (nixos) => figure out which one of those it makes sense to use!!
 - + also the flakes options (non-perSystem) are just not working very well... => make work
 - keep configuring VSCode in general
 - + default shell `zsh`

## Partially DONE
 - figure out a nicer way to access `root` special arg w/out reaching to `.debug` symbols everywhere
 - + FIGURED IT OUT => `flake.inputs.self + /.` will get the root dir
 - + TODO: a way to maybe expose this ergonomically?? maybe via my-utils or something??
 - DONE: set up SSH + Git
 - + maybe better way with [agenix](https://github.com/ryantm/agenix)??