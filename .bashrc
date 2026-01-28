# ~/.bashrc

export MAIL="louzegdo@student.s19.be"

cmpp() {
   local files=(*.c)
   local last
   
   last=$(stat -c %Y "${files[@]}" | sort -n | tail -1)
   
   clear
   cmp
   
   while :; do
   	sleep 0.2
   	current=$(stat -c %Y "${files[@]}" | sort -n | tail -1)
   	if [ "$current" != "$last" ]; then
   		last=$current
   		clear
   		cmp
   	fi
   done
}

vmpp() {
   local files=(*.c)
   local last
   
   last=$(stat -c %Y "${files[@]}" | sort -n | tail -1)
   
   clear
   vmp
   
   while :; do
   	sleep 0.2
   	current=$(stat -c %Y "${files[@]}" | sort -n | tail -1)
   	if [ "$current" != "$last" ]; then
   		last=$current
   		clear
   		vmp
   	fi
   done
}

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

  cc -Wall -Wextra -Werror -Wpedantic -Wconversion -Wshadow -Wundef -Wcast-align -O1 -g -fno-omit-frame-pointer -fsanitize=address,undefined,leak "${files[@]}" "${cc_args[@]}" && ./a.out "${run_args[@]}"
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

  cc -Wall -Wextra -Werror -Wpedantic -Wconversion -Wshadow -Wundef -Wcast-align -O1 -g -fno-omit-frame-pointer "${files[@]}" "${cc_args[@]}" \
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

  cc -Wall -Wextra -Werror -Wpedantic -Wconversion -Wshadow -Wundef -Wcast-align -O1 -g -fno-omit-frame-pointer "${files[@]}" "${cc_args[@]}" \
    && gdb --args ./a.out "${run_args[@]}"
  rm -f ./a.out
}

