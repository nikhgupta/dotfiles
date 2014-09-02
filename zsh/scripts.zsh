# Load some very essential scripts - I can't live without

## autoenv - directory specific environments
if [[ ! -d "${SCRIPT_DIR}/opt/autoenv" ]]; then
    git clone https://github.com/kennethreitz/autoenv.git $SCRIPT_DIR/opt/autoenv

    echo "-------------"
    echo "AutoEnv was installed. Please, restart your shell."
fi

# fasd - fast navigation and search
if [[ ! -f "${SCRIPT_DIR}/bin/fasd" ]]; then
    pushd /tmp
    wget https://github.com/clvv/fasd/archive/master.zip -O fasd.zip
    unzip fasd.zip
    pushd fasd-master
    PREFIX=$SCRIPT_DIR make install
    popd
    rm -rf fasd-master
    popd

    echo "-------------"
    echo "FASD was installed. Please, restart your shell."
fi

# ZSH Syntax Highlighting
if [[ ! -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]]; then
    pushd $ZSH/custom/plugins
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
    popd

    echo "-------------"
    echo "ZSH Syntax highlighting was installed. Please, restart your shell."
fi

# Load Syntax Highlighting for ZSH
# NOTE: now, done via ZSH plugins.
#
# source_file $SCRIPT_DIR/shell/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source_file "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

# Load Todo.txt
# source_file "$SCRIPT_DIR/shell/todo.txt-cli/todo_completion"
# export T="$SCRIPT_DIR/shell/todo.txt-cli/todo.sh -d $TODO_TXT_CLI_CONFIG_FILE" # handy when defining functions that depend on it.
# alias t="$T"

add_to_path_nicely "${SCRIPT_DIR}/bin" at_start
eval "$(fasd --init auto)"
source_file $SCRIPT_DIR/opt/autoenv/activate.sh

# instead use rbenv - now, resides in ~/.zshenv to make this VIM compatible
# eval "$(rbenv init -)"
# }}}
