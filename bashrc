parse_git_branch(){
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's|* \(.*\)|(\1)|'
}

parse_dir() {
	pwd 2> /dev/null | sed -E -e "s|^$HOME|~|" -e 's|.*(/[^/]*/[^/]*)|\1|' 
}

export PS1="╭─(\e[94m\u@\h\e[0m)[\$(parse_dir)]\e[33m\$(parse_git_branch)\e[0m\n╰> " 
