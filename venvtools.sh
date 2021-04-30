# venvtools
# Description: Common macros for working with virtual environments
# Author: Peter Malcolm
# Date: 02.05.21


# Config
export VENVS_DIR="$HOME/venvs"
export VENVS_PYTHON="${VENVS_PYTHON:-python3.8}"

# Functions

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


# Export Functions


# Command Completion
