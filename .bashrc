export EDITOR='vim'

parse_git_branch(){
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's|* \(.*\)|(\1)|'
}

parse_dir() {
	pwd 2> /dev/null | sed -E -e "s|^$HOME|~|" -e 's|.*(/[^/]*/[^/]*)|..\1|' 
}

parse_workspace() {
  echo "$VC_WORKSPACE" | sed -E -e "s|.*/([^/]*)|\1|"
}

parse_workspace_in_pwd() {
  if [[ $PWD/ = $VC_WORKSPACE/* ]];
  then
    echo "\e[32m\$(parse_workspace)/\e[0m"
  else
    echo "\e[31m\$(parse_workspace) \e[0m"
  fi
}


export PS1="╭─(\e[94m\u@\h\e[0m)[\$(parse_dir)]\e[33m\$(parse_git_branch)\e[0m\n╰> "

if [ -f ~/bashfiles/.aliases ];
then
    source ~/bashfiles/.aliases
fi

