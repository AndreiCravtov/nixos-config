# Configure `fzf-tab` to look how I want
#
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with `ls` when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always --group-directories-first $realpath'

# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
#zstyle ':fzf-tab:*' use-fzf-default-opts yes # TODO: figure out what this "FZF_DEFAULT_OPTS" thing is how to configure it 

# switch group using 'j;' (i.e. Left/Right)
# FIXME: cannot figure out how to make it work with LeftArrow/RightArrow!!??
zstyle ':fzf-tab:*' switch-group 'j' ';'
