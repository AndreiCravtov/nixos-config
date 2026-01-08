# A list of TODOs
 - make the my-utils thing accessible NICER than it is right now!!! (make use of submodules more??)
   OBSERVE how config.nix in handled!!!
 - make a `packages` overlay that simply overlays any packages in the `/packages` folder
   (see nixos-config example for this) + minimal "my hello" package or something (to test)...
 - figure out a way to configure Brave browser extensions installation with `brave/policies/managed/chrome-policies.json`
 - + for now we are stuck with no default extensions & having to copy everything from some kind of backup
 - + IF I EVER end up needing e.g. `vimium` then I HAVE to figure out a way to get it up and running...
 - Install jetbrains nerd fonts everywhere!! (& set for terminals + vscode + etc.)
 - **VERY IMPORTANT**: there are these "fragmented" configurations happening across NixOS modules & home manager, e.g. `zsh`, `gnome`, `kitty`, etc. **NEED TO** figure out a coherent way to link them together
 - + maybe making matching-named files in both?? e.g. `kitty` in both??
 - + maybe make "super-modules" that touch __both__ home configurations AND nixos configurations?? It would __obviously__ have to be a NixOS module in that case which simply reaches into `home-manager.users.${username}.<HOME-MANAGER-SETTINGS>` when necessary??
 - Declarative Glove80 config generation...??
 - Make `root` user have SOME of the niceties of `home user`??
 - As I begin theming more things, I want to create a Nix-ified theming solution for unified consistency ???

### Shell
 - Nushell ?????

### Language toolchains
 - haskell/python(IDLE editor)/ruby/go/android/nargo??/lean4/pnpm/ocaml

### Migrate .config from PURE home-manager to `mkOutOfStoreSymlink`/template engine combo??
 - Right for SEVERAL configurations (kitty,zsh,etc.) re-running the WHOLE configuration is really REALLY annoying
 - The soluiton is to have a seperate (mutable) configuration & use `mkOutOfStoreSymlink` HOWEVER!!
 - Sometimes I am interpolating values FROM THE NIX FLAKE (e.g. for paths to packages)
 - SO the solution is to TEMPLATE my configs somehow & on `nix run`:
 - + read config template -> substitute flake values -> write final output to __mutable__ .config path??
 - So with that, I can quickly edit the __mutable__ .config files for testing??
 - + but also if I like the changes, add the changes to the templated config for longer term??
 - + possibly add a diffing tool (.git) to track state of my temporary changes?

 - Maybe need a flake output script to "materialize" all the configs??
 - + 1) traverse home.file.??. and for each one (with filter??), `cp <nix store> <actual place>`
 - + 2) stash the symlink somewhere
 - + 3) revert when needed??
 - quite possibly need to add some kind of "filter" or "toggle" to only do this to specific files
 - + so workflow is:
 - + 1) `nix run`
 - + 2) execute this patch script
 - + 3) fiddle with configurations to your heart's content MUTABLY (e.g. in VSCode, ZSH, etc.)
 - + 4) once done, run `diff`, transfer changes to nixconfig
 - + 5) `unstash` and do `nix switch`
 
## Partially DONE
 - DONE: set up SSH + Git
 - + maybe better way with [agenix](https://github.com/ryantm/agenix)??
 - Gnome extensions
 - + make DING work (it doesn't)
 - + All the extensions made the top-bar push the battery icon offscreen!! UI BUG!!

# Read later
 - [Dependency management](https://tsawyer87.github.io/posts/declarative_depinject/)

 - Patching GNOME extensions:
 - + https://discourse.nixos.org/t/how-to-patch-the-workrave-gnome-extension-to-work-on-nixos-without-using-global-environment-variables/66271
 - + nixpkgs `replaceVars` https://nixos.org/manual/nixpkgs/stable/#ssec-gnome-common-issues-unwrappable-package
 - + where to patch https://github.com/AstraExt/astra-monitor/blob/main/src/utils/utils.ts#L319