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

### VSCode
 - keep configuring VSCode in general
 - + default shell `zsh`

### Language toolchains
 - haskell/python(IDLE editor)/ruby/go/android/nargo??/lean4/pnpm/ocaml

## Partially DONE
 - DONE: set up SSH + Git
 - + maybe better way with [agenix](https://github.com/ryantm/agenix)??
 - Gnome extensions
 - + make DING work (it doesn't)
 - + write a patch for Astra Monitor so it doesn't need to set environment flags (like it does currently)

 ---

# OLD TODO
- IDE apps

Issues:
- random connectivity issues with wifi...
- bluetooth issues
- wired mice issues: right-click working incorrectly
- middle mouse not closing tabs...
- desktop icons not working...
- maybe not use rustup?? or make it more declarative??
- brightness of screen not working??
- telegram-desktop installed but not working ????

---
Imperative log:
- brave
- + extensions & their settings
- + defautlt settings like search enginelast
- gnome
- + power mode configs
- intellij toolbox installed (TODO: re-do everything declaritively)
