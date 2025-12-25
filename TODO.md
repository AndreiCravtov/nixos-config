# A list of TODOs
 - make the my-utils thing accessible NICER than it is right now!!! (make use of submodules more??)
   OBSERVE how config.nix in handled!!!
 - make a `packages` overlay that simply overlays any packages in the `/packages` folder
   (see nixos-config example for this) + minimal "my hello" package or something (to test)...
 - + https://github.com/lsd-rs/lsd?tab=readme-ov-file#configuring-your-shell-to-use-lsd-instead-of-ls-optional
 - figure out a way to configure Brave browser extensions installation with `brave/policies/managed/chrome-policies.json`
 - + for now we are stuck with no default extensions & having to copy everything from some kind of backup
 - + IF I EVER end up needing e.g. `vimium` then I HAVE to figure out a way to get it up and running...
 - Install jetbrains nerd fonts everywhere!! (& set for terminals + vscode + etc.)
 - **VERY IMPORTANT**: there are these "fragmented" configurations happening across NixOS modules & home manager, e.g. `zsh`, `gnome`, `kitty`, etc. **NEED TO** figure out a coherent way to link them together
 - + maybe making matching-named files in both?? e.g. `kitty` in both??
 - + maybe make "super-modules" that touch __both__ home configurations AND nixos configurations?? It would __obviously__ have to be a NixOS module in that case which simply reaches into `home-manager.users.${username}.<HOME-MANAGER-SETTINGS>` when necessary??

### Shell
 - Nushell ?????

### System settings
 - default apps e.g. default browser = brave

### VSCode
 - keep configuring VSCode in general
 - + default shell `zsh`

## Partially DONE
 - DONE: set up SSH + Git
 - + maybe better way with [agenix](https://github.com/ryantm/agenix)??
 - Gnome extensions
 - + make DING work (it doesn't)
 - + write a patch for Astra Monitor so it doesn't need to set environment flags (like it does currently)