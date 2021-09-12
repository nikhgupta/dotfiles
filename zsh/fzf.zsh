# source fzf keybindings
export BAT_THEME=Nord
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_PREVIEW_COMMAND="$HOME/.bin/fzf-preview.zsh {}"
export FZF_DEFAULT_OPTS="
--sort 100000
--ansi
--layout=reverse
--info=inline
--height=60%
--multi
--preview-window='right:60%'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='$ ' --pointer='▶' --marker='✓'
--bind 'ctrl-\\:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-x:execute(code {+})'
"

# fzf with previews
alias fzfpr="fzf --preview='$FZF_PREVIEW_COMMAND'"

# search for a needle in all files
alias rgf='rg -Sl --color=never --no-messages --hidden --smart-case -g "!{.git,node_modules,vendor}/*"'

_fzf_compgen_path() { fd . "$1"; }
_fzf_compgen_dir() { fd --type d . "$1"; }
