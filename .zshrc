# ~/.zshrc

export MAIL="louzegdo@student.s19.be"

cmp() {
  local -a files cc_args run_args
  local mode=cc

  while IFS= read -r -d '' f; do
    files+=("$f")
  done < <(find . -name '*.c' -print0)

  for arg in "$@"; do
    if [[ "$arg" == "--" ]]; then
      mode=run
      continue
    fi
    if [[ "$mode" == cc ]]; then
      cc_args+=("$arg")
    else
      run_args+=("$arg")
    fi
  done

  cc -Wall -Wextra -Werror -g "${files[@]}" "${cc_args[@]}" && ./a.out "${run_args[@]}"
  rm -f ./a.out
}

vmp() {
  local -a files cc_args run_args
  local mode=cc

  while IFS= read -r -d '' f; do
    files+=("$f")
  done < <(find . -name '*.c' -print0)

  for arg in "$@"; do
    if [[ "$arg" == "--" ]]; then
      mode=run
      continue
    fi
    if [[ "$mode" == cc ]]; then
      cc_args+=("$arg")
    else
      run_args+=("$arg")
    fi
  done

  cc -Wall -Wextra -Werror -g "${files[@]}" "${cc_args[@]}" \
    && valgrind --leak-check=full --track-origins=yes ./a.out "${run_args[@]}"
  rm -f ./a.out
}

gmp() {
  local -a files cc_args run_args
  local mode=cc

  while IFS= read -r -d '' f; do
    files+=("$f")
  done < <(find . -name '*.c' -print0)

  for arg in "$@"; do
    if [[ "$arg" == "--" ]]; then
      mode=run
      continue
    fi
    if [[ "$mode" == cc ]]; then
      cc_args+=("$arg")
    else
      run_args+=("$arg")
    fi
  done

  cc -Wall -Wextra -Werror -g "${files[@]}" "${cc_args[@]}" \
    && gdb --args ./a.out "${run_args[@]}"
  rm -f ./a.out
}

