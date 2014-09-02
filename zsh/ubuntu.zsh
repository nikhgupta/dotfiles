# Ubuntu dev server specific ZSH configuration.
# =============================================
[[ `hostname` == 'HomePC' && `uname -a` =~ 'Ubuntu' ]] || return
alias zshmachine="edit $DOTZSH/ubuntu.zsh"     # quickly edit OS specific config

function update_system() {
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade -y
    sudo apt-get autoremove
}
