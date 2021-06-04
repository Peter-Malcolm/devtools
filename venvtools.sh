# venvtools
# Description: Common macros for working with virtual environments
# Author: Peter Malcolm
# Date: 06.06.21
# Versiom: 0.3


# config

export VENVS_DIR="$HOME/venvs"
export VENVS_PYTHON="${VENVS_PYTHON:-python3.8}"


# functions
# TODO - specify python version

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
  [ ! -d "${VENVS_DIR}/${name}" ] && echo "usenv: venv ${name} not found" && return 1
	. "${VENVS_DIR}/${name}/bin/activate"
}

cdenv(){  # navigate to a venv working dir
	[ $# -ne 1 ] && echo "cdenv: must specify venv name" && return 1
  local name="$1"
  [ ! -d "${VENVS_DIR}/${name}" ] && echo "cdenv: venv ${name} not found" && return 1
  cd "${VENVS_DIR}/${name}"
}

deenv(){  # stop using a virtual environment
	[ $# -ne 0 ] && echo "deenv: takes no arguments" && return 1
	deactivate
}

reenv(){  # recreate a virtual environment
	[ $# -ne 1 ] && echo "reenv: must specify venv name" && return 1
  local name="$1"
	"${VENVS_PYTHON}" -m venv "${VENVS_DIR}/${name}" --clear
}


# completions
_venvtools_completions()
{
  COMPREPLY=($(compgen -W "$(ls "${VENVS_DIR}")" "${COMP_WORDS[1]}"))
}

for fn in usenv cdenv reenv; do
        complete -F _venvtools_completions "${fn}"
done


# export to subshells
for fn in lsenv mkenv usenv cdenv deenv reenv; do
        export -f "${fn}"
done

