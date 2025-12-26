# Copied from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/magic-enter/magic-enter.plugin.zsh

# Default commands
: ${MAGIC_ENTER_GIT_COMMAND:="git status -u ."} # run when in a git repository
: ${MAGIC_ENTER_JJ_COMMAND:="jj st --no-pager ."} # run when in a jj repository
: ${MAGIC_ENTER_OTHER_COMMAND:="ls -lh ."}      # run anywhere else

magic-enter() {
  # Only run MAGIC_ENTER commands when in PS1 and command line is empty
  # http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#User_002dDefined-Widgets
  if [[ -n "$BUFFER" || "$CONTEXT" != start ]]; then
    return
  fi

  # needs to be before git to handle colocated repositories
  if (( $+commands[jj] )) && command jj st >/dev/null 2>&1; then
    BUFFER="$MAGIC_ENTER_JJ_COMMAND"
  elif (( $+commands[git] )) && command git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    BUFFER="$MAGIC_ENTER_GIT_COMMAND"
  else
    BUFFER="$MAGIC_ENTER_OTHER_COMMAND"
  fi
}

# Helper: disable ysu for exactly one command, then re-enable at next prompt
_magic_enter_ysu_suspend_once() {
  local disable_fn enable_fn

  # Current upstream names:
  if (( $+functions[disable_you_should_use] && $+functions[enable_you_should_use] )); 
  then
  else
    return 0
  fi

  disable_you_should_use

  autoload -Uz add-zsh-hook

  # one-shot re-enable after the command finishes (next prompt)
  _magic_enter_ysu_resume() {
    add-zsh-hook -d precmd _magic_enter_ysu_resume 2>/dev/null || true
    enable_you_should_use
  }
  add-zsh-hook precmd _magic_enter_ysu_resume
}

# Wrapper for the accept-line zle widget (run when pressing Enter)

# If the wrapper already exists don't redefine it
(( ! ${+functions[_magic-enter_accept-line]} )) || return 0

case "$widgets[accept-line]" in
  # Override the current accept-line widget, calling the old one
  user:*) zle -N _magic-enter_orig_accept-line "${widgets[accept-line]#user:}"
    function _magic-enter_accept-line() {
      local orig_buffer=$BUFFER
      local orig_context=$CONTEXT

      magic-enter

      # If magic-enter injected a command, suppress ysu for this one execution
      if [[ -z $orig_buffer && $orig_context == start && -n $BUFFER ]]; then
        _magic_enter_ysu_suspend_once
      fi

      zle _magic-enter_orig_accept-line -- "$@"
    } ;;
  # If no user widget defined, call the original accept-line widget
  builtin) function _magic-enter_accept-line() {
      local orig_buffer=$BUFFER
      local orig_context=$CONTEXT

      magic-enter

      if [[ -z $orig_buffer && $orig_context == start && -n $BUFFER ]]; then
        _magic_enter_ysu_suspend_once
      fi

      zle .accept-line
    } ;;
esac

zle -N accept-line _magic-enter_accept-line