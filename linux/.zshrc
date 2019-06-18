#!/usr/bin/env zsh
#
#   Configuration inside `~/.zshrc` is only sourced by interactive
#   shells, and hence, GUI programs like MacVim can not load any
#   configuration from this file. Please, keep that in mind.
#
#   This configuration makes use of several programs and/or scripts, and
#   is best utilized with all of the following dependencies being
#   present in the system. If you prefer, you can install all these
#   dependencies (if you are on a Mac or Ubuntu), by running the
#   installer script at: `./scripts/dep-installer`
#
#   - homebrew (or linuxbrew on Ubuntu) - zsh, oh-my-zsh, and
#   zsh-syntax-highlighting - cowsay, fortune, fasd and autoenv
#
#   Although, you do not necessarily need to install these dependencies
#   and the configuration should work without any problem.
#
#   On MacOSX, completions are picked up from the Homebrew managed path
#   at `/usr/local/share/zsh/site-functions`. Certain binaries like
#   `git` do not add completions to this directory. However, we can
#   always add a symlink for completions of these binaries in this
#   directory.
#
#   I have not tested this on Ubuntu, but we can always add a new
#   directory to the `$fpath` variable, where all such completions can
#   be present.
#
#   Additionally, for convenience, `~/.zsh/completions` is already added
#   to `$fpath`, and hence, on both MacOSX and Ubuntu, you can add your
#   completions to this directory.
#
#   05-06-19 21:22:18: Using `rg` in place of ag, pt, grep, ack, etc.
#   05-06-19 21:22:18: Using `fd` in place of find
#   05-06-19 21:22:18: Using `fzf` in place of fasd, etc.

# => basic locales and ZSH options
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LANGUAGE=en_US.UTF-8
# skip_global_compinit=1

# Reference: http://zsh.sourceforge.net/Doc/Release/Options.html
setopt no_beep                  # do not beep
setopt auto_pushd               # cd pushes the old directory onto directory stack
setopt pushd_silent             # be quiet when using pushd
setopt pushd_ignore_dups        # only push unique values in directorys stack
setopt menu_complete            # complete first option when ambiguous
setopt hist_expire_dups_first   # expire older dup commands first in history
setopt hist_find_no_dups        # do not find dupes when searching history
setopt hist_ignore_space        # do not add commands with a leading space in history
setopt hist_no_store            # do not add 'history' command in history
setopt rm_star_wait             # wait for 10 seconds before accepting the answer
unsetopt rm_star_silent         # Query the user on such a removal
unsetopt nomatch
unsetopt correct_all

# other terminal related basic configuration
typeset -U path # set $path variable to only have unique values

export TERM=screen-256color
export GREP_COLORS=31        # grep should use red for highlighting matches
export MAILCHECK=0

# Please, don't ask to update, O! OhMyZSH. Just do it.
export DISABLE_UPDATE_PROMPT=true
export DISABLE_AUTO_TITLE=true # otherwise, causes issues with terminal inside editors

# => load OhMyZSH and some relevant plugins
plugins=(bundler coffee common-aliases emoji-clock extract bgnotify
branch fzf gem golang history-substring-search ssh-agent transfer)
is_macosx && plugins+=( osx )

source $ZSH/oh-my-zsh.sh || echo '[WARN] OhMyZSH was not loaded.'

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities nikhgupta
ssh-add ~/.ssh/nikhgupta

unalias run-help &>/dev/null; autoload run-help

# set vim bindings for zsh
bindkey -v
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char      # Control-h also deletes the previous char
bindkey "^U" backward-kill-line

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
# bindkey '^[OB' history-beginning-search-forward
# bindkey '^[OA' history-beginning-search-backward
# bindkey '^a' beginning-of-line
# bindkey '^e' end-of-line
# # Use Ctrl-x,Ctrl-l to get the output of the last command
# zmodload -i zsh/parameter
# insert-last-command-output() { LBUFFER+="$(eval $history[$((HISTCMD-1))])"; }
# zle -N insert-last-command-output
# bindkey '^x^l' insert-last-command-output

source ~/.zsh/aliases.zsh
source ~/.zsh/fuzzy.zsh
source ~/.zsh/prompt.zsh
source_if_exists ~/.zshrc.local

if [ -f ~/.zsh_nocorrect ]; then
  while read -r COMMAND; do alias $COMMAND="nocorrect $COMMAND"; done < ~/.zsh_nocorrect
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# => add ~/.zsh to functions' path in ZSH can be used for adding completions
[[ -d ~/.zsh/completions ]] && fpath=( ~/.zsh/completions $fpath )
source ~/.zsh/completions/_tmuxinator
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
