function in_git_tree {
	git rev-parse --is-inside-work-tree &> /dev/null
}

function parse_git_branch {
	if in_git_tree
	then
		local BR=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2> /dev/null)
		if ["$BR" == HEAD]
		then
			local NM=$git name-rev --name-only HEAD 2> /dev/null
			if [ "$NM" != undefined ]
			then
				echo -n "@$NM"
			else
				git rev-parse --short HEAD 2> /dev/null
			fi
		else
			echo -n $BR
		fi
	fi
}

function parse_git_status {
	if in_git_tree
	then
		local ST=$(git status --short 2> /dev/null)
		if [ -n "$ST" ]
		then echo -n " + "
		else echo -n " - "
		fi
	fi
}

function pwd_depth_limit_2 {
	if ["$PWD" = "$HOME" ]
	then echo -n "~"
	else pwd | sed -e  "s|.*/\(.*/.*\)|\1|"
	fi
}

BROWN="\[\033[1;33m\]"
RED="\[\033[1;31m\]"
CLEAR="\[\033[0m\]"

export -f parse_git_branch parse_git_status in_git_tree pwd_depth_limit_2
export PS1="$BROWN\u@\w$RED\$(parse_git_status)$BROWN\$(parse_git_branch) $RED>$CLEAR "
export TERM="xterm-color"
