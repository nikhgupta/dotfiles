#!/usr/bin/env zsh
#
# Scripts are stored in ~/Code/scripts
# Subs are based upon: http://github.com/basecamp/subs

# Behaviour: Custom functions {{{
restart_shell_message() {
  echo "-------------"
  echo "$@ was installed. Please, restart your shell."
}
# }}}
# Install: ZSH Plugin: Syntax Highlighting {{{
if [[ ! -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]]; then
  mkdir -p $ZSH/custom/plugins
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
  restart_shell_message "ZSH Syntax highlighting"
fi
# zsh_debug_time "ZSH Syntax highlighting loaded"
# }}}
# Install: autoenv - directory specific environments {{{
if [[ ! -f "${SCRIPT_DIR}/autoenv/activate.sh" ]]; then
  git clone https://github.com/kennethreitz/autoenv.git $SCRIPT_DIR/autoenv
  restart_shell_message "AutoEnv"
fi
source_file $SCRIPT_DIR/autoenv/activate.sh
# zsh_debug_time "Script: autoenv loaded"
# }}}
# Install: fasd - fast navigation and search {{{
if ! installed fasd && [[ ! -f "${SCRIPT_DIR}/fasd/bin/fasd" ]]; then
    pushd /tmp
    wget https://github.com/clvv/fasd/archive/master.zip -O fasd.zip
    unzip fasd.zip
    pushd fasd-master
    PREFIX=$SCRIPT_DIR/fasd make install
    popd
    popd
    rm -rf /tmp/fasd-master
    restart_shell_message "FASD"
fi
which fasd &>/dev/null || add_to_path_nicely "$SCRIPT_DIR/fasd/bin"
eval "$(fasd --init auto)"
# zsh_debug_time "Script: fasd loaded"
# }}}
# Tweet to Twitter based journal from command line {{{
# Requires: http://sferik.github.com/t
# TODO: hardcoded values
if which t &>/dev/null; then
  unalias t &>/dev/null # ZSH has a plugin that defines an alias with that name
  t_journal() {
    t set active JournalOfNikhil
    t $@
    t set active nikhgupta &>/dev/null
    echo "---------"
    echo 'NOTE: To use `t` with this account, use `t_journal` command, instead.'
  }
  t_all() {
    for account in `t accounts | egrep -v '^\s+'`; do
      t set active $account
      t $@
      echo "---------"
    done
  }
  alias t_log="t_journal update"

  # source zsh completion
  local completion_file=$ZSH_COMPL_DIR/t-completion.zsh
  if [ ! -f "${completion_file}" ]; then
    mkdir -p $ZSH_COMPL_DIR
    wget https://raw.githubusercontent.com/sferik/t/master/etc/t-completion.zsh -O $completion_file
  fi
  source_file $completion_file

  # make the primary account active by default in new shells
  if cat ~/.trc | tr '\n' ' ' | egrep 'default.*?-.*?-' -o | grep nikhgupta -v; then
    t set active nikhgupta
  fi
fi
# zsh_debug_time "Script: Journal loaded"
# }}}
# load custom scripts, if present
for sub in `find $SCRIPT_DIR -iname '*-sh-shell' -exec basename {} \;`; do 
  sub="${sub%-sh-shell}"
  [ -f "$SCRIPT_DIR/$sub/bin/$sub" ] && eval "$($SCRIPT_DIR/$sub/bin/$sub init -)"
  # zsh_debug_time "Script: $sub loaded"
done
