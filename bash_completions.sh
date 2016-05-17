_ssh_complete() {
  # the split takes care of the case where the line is separated by spaces
  # instead of the more normal commas
  COMPREPLY=( $(awk -F ',' -v regex="^$2" '$0 ~ regex {split($1, parts, " ");print parts[1]}' ~/.ssh/known_hosts) )
}

complete -o bashdefault -o default -F _ssh_complete ssh

# git commands
_branches_in_repo() {
  if [[ $3 == "checkout" ]];
  then
    COMPREPLY=( $(git branch | tr -d " \*" | grep "^$2") )
  fi
}

_git_complete() {
  # git sub commands, the case where the previous
  # word ("git") equals the command
  if [[ $3 == $1 ]];
  then
    COMPREPLY=( $(git | awk -v regex="^ +[a-z]" '$0 ~ regex {print $1}' | grep "^$2") )
  elif [[ $3 == "checkout" ]];
  then
    _branches_in_repo $1 $2 $3
  fi
}

complete -o bashdefault -o default -F _git_complete git
