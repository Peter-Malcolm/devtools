# projecttools
# Description: Common macros for creating new projects.
# Author: Peter Malcolm
# Date: 02.05.21


# config

export PROJECTS_DIR="${PROJECTS_DIR:-$HOME/projects}"


# functions

lsproj(){
	echo "listing recent projects"
	echo
        ls -lt "${PROJECTS_DIR}" | awk '{print $9,$6,$7,$8}' | column -t
}

mkproj(){  # create a new project
        [ $# -ne 1 ] && echo "mkproj: must specify project name" && return 1
	local proj="$1"
	echo "creating project: ${proj}"

	mkdir -p "${PROJECTS_DIR}/${proj}/"
	mkdir -p "${PROJECTS_DIR}/${proj}/.projecttools"

	echo "created project: ${proj}"
	echo "type 'cdproj ${proj}' to start using it"
}

cdproj(){  # navigate to project directory
        [ $# -ne 1 ] && echo "cdproj: must specify project name" && return 1
        local proj="$1"
	[ ! -d "${PROJECTS_DIR}/${proj}" ] && echo "cdproj: project ${proj} not found" && return 1
	echo "switching to project: ${proj}"
	echo
	echo "listing project contents"
        cd "${PROJECTS_DIR}/${proj}"
	ls -la
}

initproj() {   # run project specific setup
	[ $# -ne 1 ] && echo "initproj: must specify project name" && return 1
	local proj="$1"
	local init="${PROJECTS_DIR}/${proj}/.projtools/init.sh"
   	[ -f "${init}" ] && echo && echo "initalising project: ${proj}" && . "${init}"
}


useproj() {  # navigate to project directory and run init scripts
	[ $# -ne 1 ] && echo "useproj: must specify project name" && return 1
	local proj="$1"
	cdproj "$@"
	initproj "$@"
}

deproj() {  # stop using a project  # TODO - implement properly
	[ $# -ne 0 ] && echo "deproj: takes no arguments" && return 1
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
