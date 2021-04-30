# projecttools
# Description: Common macros for creating new projects.
# Author: Peter Malcolm
# Date: 02.05.21


# config

export PROJECTS_DIR="${PROJECTS_DIR:-$HOME/projects}"

export PROJECT_HOOKFILE

# functions

lsproj(){
        ls -lt "${PROJECTS_DIR}" | awk '{print $9,$6,$7,$8}' | column -t
}

mkproj(){  # create a new project
        [ $# -eq 1 ] || echo "mkproj: must specify project name" && return 1
	local proj="$1"
	echo "creating project: ${proj}"

	mkdir -p "${PROJECTS_DIR}/${proj}"

	echo "created project: ${proj}"
	echo "type 'cdproj ${proj}' to start using it"
}

cdproj(){  # navigate to project directory
        [ $# -eq 1 ] || echo "cdproj: must specify project name" && return 1
        local proj="$1"
	echo "switching to project: ${proj}"
`	echo
	echo "listing project contents"
        cd "${PROJECTS_DIR}/${proj}"
	ls -l
}


useproj() {  # navigate to project directory and run init scripts
	[ $# -eq 1 ] || echo "useproj: must specify project name" && return 1
	cdproj "$@"
	local proj="$1"
	echo
	echo "running prehook"
	local prehook="${PROJECTS_DIR}/${proj}/.projecthooks"
}


# completions
_projtools_completions()
{
  COMPREPLY=($(compgen -W "$(ls "${PROJECTS_DIR}")" "${COMP_WORDS[1]}"))
}
for fn in cdproj useproj; do
	complete -F _projtools_completions "${fn}"
done


# export to subshells
for fn in lsproj mkproj cdproj useproj; do
	export -f "${fn}"
done
