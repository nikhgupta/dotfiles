#!/usr/bin/env zsh

# Behaviour: Custom functions {{{
restart_shell_message() {
  echo "-------------"
  echo "$@ was installed. Please, restart your shell."
}
# }}}
# Install: autoenv - directory specific environments {{{
if [[ ! -d "${SCRIPT_DIR}/opt/autoenv" ]]; then
    git clone https://github.com/kennethreitz/autoenv.git $SCRIPT_DIR/opt/autoenv
    restart_shell_message "AutoEnv"
fi
# }}}
# Install: fasd - fast navigation and search {{{
if ! installed fasd && [[ ! -f "${SCRIPT_DIR}/bin/fasd" ]]; then
    pushd /tmp
    wget https://github.com/clvv/fasd/archive/master.zip -O fasd.zip
    unzip fasd.zip
    pushd fasd-master
    PREFIX=$SCRIPT_DIR make install
    popd
    popd
    rm -rf /tmp/fasd-master
    restart_shell_message "FASD"
fi
# }}}
# Install: ZSH Syntax Highlighting {{{
if [[ ! -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]]; then
  mkdir -p $ZSH/custom/plugins
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
  restart_shell_message "ZSH Syntax highlighting"
fi
# }}}
# Behaviour: Scripts configuration {{{
add_to_path_nicely "${SCRIPT_DIR}/bin" at_start
eval "$(fasd --init auto)"
source_file $SCRIPT_DIR/opt/autoenv/activate.sh
# }}}
