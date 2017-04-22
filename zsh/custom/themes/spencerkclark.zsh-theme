# Mostly copied from Armin Ronacher's setup:
# https://github.com/mitsuhiko/dotfiles/blob/master/zsh/custom/themes/mitsuhiko.zsh-theme
# It is modified to remove the mercurial, virtualenv,
# and multirust plugin dependencies.  It also removes iTerm2 specific logic.

setopt prompt_subst

export LSCOLORS=ExGxFxDxCxHxHxCbCeEbEb

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[blue]%}git%{$reset_color%}:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_BRANCH=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]?%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[cyan]%}%{+%G%}"

# If no specific CONDA_DEFAULT_ENV is set, note that the default
# conda environment is being used.
if [[ -z "$CONDA_DEFAULT_ENV" ]]; then
    CONDA_DEFAULT_ENV="default"
fi

# This is the basic prompt that is always printed.  It will be
# enclosed to make it newline.
_SPENCERKCLARK_PROMPT='%{$fg[magenta]%}%n [$CONDA_DEFAULT_ENV]%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg[green]%}%~%{$reset_color%}%'

# This is the base prompt that is rendered sync.  It should be
# fast to render as a result.  The extra whitespace before the
# newline is necessary to avoid some rendering bugs.
PROMPT=$'\n'$_SPENCERKCLARK_PROMPT$' \n$ '
RPROMPT=''

# The pid of the async prompt process and the communication file
_SPENCERKCLARK_ASYNC_PROMPT=0
_SPENCERKCLARK_ASYNC_PROMPT_FN="/tmp/.zsh_tmp_prompt_$$"

# Remove the default git var update from chpwd and precmd to speed
# up the shell prompt.  We will do the precmd_update_git_vars in
# the async prompt instead
chpwd_functions=("${(@)chpwd_functions:#chpwd_update_git_vars}")
precmd_functions=("${(@)precmd_functions:#precmd_update_git_vars}")

# This here implements the async handling of the prompt.  It
# runs the expensive git parts in a subprocess and passes the
# information back via tempfile.
function _spencerkclark_precmd() {
  _spencerkclark_rv=$?

  function async_prompt() {
      # Run the git var update here instead of in the parent
      precmd_update_git_vars

      #
      echo -n $'\n'$_SPENCERKCLARK_PROMPT$' '$(git_super_status) > $_SPENCERKCLARK_ASYNC_PROMPT_FN
          if [[ x$_spencerkclark_rv != x0 ]]; then
              echo -n " exited %{$fg[red]%}$_spencerkclark_rv%{$reset_color%}" >> $_SPENCERKCLARK_ASYNC_PROMPT_FN
          fi
              echo -n $'\n$ ' >> $_SPENCERKCLARK_ASYNC_PROMPT_FN

      # signal parent
      kill -s USR1 $$
   }

# If we still have a prompt async process we kill it to make sure
# we do not backlog with useless prompt things.  This also makes
# sure that we do not have prompts interleave in the tempfile.
if [[ "${_SPENCERKCLARK_ASYNC_PROMPT}" != 0 ]]; then
    kill -s HUP $_SPENCERKCLARK_ASYNC_PROMPT >/dev/null 2>&1 || :
fi

# start background computation
async_prompt &!
      _SPENCERKCLARK_ASYNC_PROMPT=$!
}

# This is the trap for the signal that updates our prompt and
# redraws it.  We intentionally do not delete the tempfile here
# so that we can reuse the last prompt for successive commands
function _spencerkclark_trapusr1() {
  PROMPT="$(cat $_SPENCERKCLARK_ASYNC_PROMPT_FN)"
  _SPENCERKCLARK_ASYNC_PROMPT=0
  zle && zle reset-prompt
}

# Make sure we clean up our tempfile on exit
function _spencerkclark_zshexit() {
  rm -f $_SPENCERKCLARK_ASYNC_PROMPT_FN
}

# Hook our precmd and zshexit functions and USR1 trap
precmd_functions+=(_spencerkclark_precmd)
zshexit_functions+=(_spencerkclark_zshexit)
trap '_spencerkclark_trapusr1' USR1
