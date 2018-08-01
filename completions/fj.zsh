if [[ ! -o interactive ]]; then
    return
fi

compctl -K _fj fj

_fj() {
  local word words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(fj commands)"
  elif [ "${#words}" -gt 2 ]; then
    completions="$(fj commands "$words")"
  fi

  reply=("${(ps:\n:)completions}")
}
