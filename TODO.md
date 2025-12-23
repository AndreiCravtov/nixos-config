# A list of TODOs
 - make the my-utils thing accessible NICER than it is right now!!! (make use of submodules more??)
   OBSERVE how config.nix in handled!!!
 - make a `packages` overlay that simply overlays any packages in the `/packages` folder
   (see nixos-config example for this) + minimal "my hello" package or something (to test)...
 - make aliases for "better" commands e.g. `ls <- lsd` as a strictly better `ls`
 - + https://github.com/lsd-rs/lsd?tab=readme-ov-file#configuring-your-shell-to-use-lsd-instead-of-ls-optional
 - install nerdfonts => enable systemwide!!
 - figure out a way to configure Brave browser extensions installation with `brave/policies/managed/chrome-policies.json`
 - + for now we are stuck with no default extensions & having to copy everything from some kind of backup
 - + IF I EVER end up needing e.g. `vimium` then I HAVE to figure out a way to get it up and running...

### Shell
 - break up `shell.nix` into OPTION GUARDED folder of modules, one file for each shell
 - + then dependencies on shell integration (e.g. `programs.nix-index.enableZshIntegration`)
     can be guarded behind a `mkIf config.zsh.enabled` or something like that ??
 - configure kitty & friends
 - + install jetbrains nerd fonts everywhere!! (& set for terminals + github + etc.)

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