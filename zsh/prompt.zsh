PROMPT=$'%{$fg[blue]%}%2c%{$reset_color%} %{$fg[red]%}$(rvm_prompt_info_custom)%{$reset_color%} $(git_prompt_info)%{$reset_color%}%{$fg_bold[yellow]%}$%{$reset_color%} '

PROMPT2="%{$fg_bold[black]%}%_> %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function rvm_prompt_info_custom() {
	info=$(rvm_prompt_info)
	echo $info | sed -e 's/ruby-//' -e 's/@/ /' -e 's/(/[/' -e 's/)/]/'
}
