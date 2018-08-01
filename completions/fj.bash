_fj() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(fj commands)" -- "$word") )
  elif [ "$COMP_CWORD" -gt 1 ]; then
  	commands="$(fj commands ${COMP_WORDS[@]})"
  	if [ "$commands" ]; then
    	COMPREPLY=( $(compgen -W "$commands" -- "$word") )
    else
    	return 1
    fi
  fi
}

complete -o default -F _fj fj
