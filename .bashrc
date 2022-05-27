parse_git_branch(){
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's|* \(.*\)|(\1)|'
}

parse_dir() {
	pwd 2> /dev/null | sed -E -e "s|^$HOME|~|" -e 's|.*(/[^/]*/[^/]*)|\1|' 
}

export PS1="\e[33m[\u@\h \$(parse_dir)]\e[32m\$(parse_git_branch)$clrcolor\e[0m "
