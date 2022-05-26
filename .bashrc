parse_git_branch() {
	     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
     }

parse_dir() {
	pwd 2> /dev/null | sed -E -e "s|^$HOME|~|" -e 's|.*(/[^/]*/[^/]*)|\1|' 
#	pwd 2> /dev/null | sed -E -e "s|^$HOME|~|" -e 's|^([^/]*/[^/]*/).*(/[^/]*)|\1..\2|' 
}

export PS1="\u@\h \[\033[32m\]\$(parse_dir)\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
