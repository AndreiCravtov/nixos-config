# A list of TODOs
 - make the my-utils thing accessible NICER than it is right now!!! (make use of submodules more??)
   OBSERVE how config.nix in handled!!!
 - make a `packages` overlay that simply overlays any packages in the `/packages` folder
   (see nixos-config example for this) + minimal "my hello" package or something (to test)...
 - break up `shell.nix` into OPTION GUARDED folder of modules, one file for each shell
 - + then dependencies on shell integration (e.g. `programs.nix-index.enableZshIntegration`)
     can be guarded behind a `mkIf config.zsh.enabled` or something like that ??

### System settings
 - gnome extensions
 - + suspend option
 - + blur & friends
 - default apps e.g. default browser = brave

### VSCode
 - keep configuring VSCode in general
 - + default shell `zsh`

## Partially DONE
 - DONE: set up SSH + Git
 - + maybe better way with [agenix](https://github.com/ryantm/agenix)??