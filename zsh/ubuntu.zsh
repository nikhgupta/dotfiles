# Ubuntu dev server specific ZSH configuration.
# =============================================
[[ `hostname` == 'HomePC' && `uname -a` =~ 'Ubuntu' ]] || return

function update_system() {
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade -y
    sudo apt-get autoremove
}
