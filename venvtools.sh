# venvtools
# Description: Common macros for working with virtual environments
# Author: Peter Malcolm
# Date: 02.05.21


# config

export VENVS_DIR="$HOME/venvs"
export VENVS_PYTHON="${VENVS_PYTHON:-python3.8}"


# functions

lsenv(){  # list all available virtual environments
	ls -lt "$VENVS_DIR" | awk '{print $9,$6,$7,$8}' | column -t
}

mkenv(){  # create a new virtual environment
	[ $# -ne 1 ] && echo "mkenv: must specify venv name" && return 1
	local name="$1"
	"${VENVS_PYTHON}" -m venv "${VENVS_DIR}/${name}"
}

usenv(){  # switch to an existing virtual environment
	[ $# -ne 1 ] && echo "usenv: must specify venv name" && return 1
        local name="$1"
	. "${VENVS_DIR}/${name}/bin/activate"
}


deenv(){  # stop using a virtual environment
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

