# venvtools
# Description: Common macros for working with virtual environments
# Author: Peter Malcolm
# Date: 02.05.21


# config

export VENVS_DIR="$HOME/venvs"
export VENVS_PYTHON="${VENVS_PYTHON:-python3.8}"


# functions

lsenv(){
	ls -lt "$VENVS_DIR" | awk '{print $9,$6,$7,$8}' | column -t
}

mkenv(){
	[ $# -eq 1 ] || echo "mkenv: specify venv name"
	NAME="$1"
	"${VENVS_PYTHON}" -m venv "${VENVS_DIR}/${NAME}"
}

usenv(){
	[ $# -eq 1 ] || echo "mkenv: specify venv name"
        NAME="$1"
	. "${VENVS_DIR}/${NAME}/bin/activate"
}


deenv(){
	deactivate
}


# completions
_venvtools_completions()
{
  COMPREPLY=($(compgen -W "$(ls "${VENVS_DIR}")" "${COMP_WORDS[1]}"))
}
for fn in usenv; do
        complete -F _venvtools_completions "${fn}"
done


# export to subshells
for fn in lsenv mkenv usenv deenv; do
        export -f "${fn}"
done

