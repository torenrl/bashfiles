export EDITOR='vim'

parse_git_branch(){
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's|* \(.*\)|(\1)|'
}

parse_dir() {
  if [ -v WS ]
  then
    parse_workspace_in_pwd 
    pwd 2> /dev/null | sed -E -e "s|^$WS||" -e "s|^$HOME|~|" -e 's|.*(/[^/]*/[^/]*)|..\1|' 
  else
    pwd 2> /dev/null | sed -E -e "s|^$HOME|~|" -e 's|.*(/[^/]*/[^/]*)|..\1|' 
  fi
}

parse_workspace() {
   echo -n "$WS" | sed -E -e "s|.*/([^/]*)|\1|"
}

parse_workspace_in_pwd() {
  if [[ $PWD/ = $WS/* ]];
  then
    echo -en '\033[0;32m'
    parse_workspace
    echo -en '/\033[0m'
  else
    echo -en '\033[0;31m'
    parse_workspace
    echo -en ' \033[0m'
  fi
}


export PS1="╭─(\e[94m\u@\h\e[0m)[\$(parse_dir)]\e[33m\$(parse_git_branch)\e[0m\n╰> "

if [ -f ~/bashfiles/.aliases ];
then
    source ~/bashfiles/.aliases
fi

