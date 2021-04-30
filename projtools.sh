# projecttools
# Description: Common macros for creating new projects.
# Author: Peter Malcolm
# Date: 02.05.21


# Config
export PROJECTS_DIR="$HOME/projects"

# Functions

lsproj(){
        ls -lt "${PROJECTS_DIR}" | awk '{print $9,$6,$7,$8}' | column -t
}

mkproj(){
        [ $# -eq 1 ] || echo "mkproj: must specify project name"
	local proj="$1"
	echo "creating project: ${proj}"
	mkdir -p "${PROJECTS_DIR}/${proj}"
}

cdproj(){
        [ $# -eq 1 ] || echo "cdproj: specify project name"
        local proj="$1"
	echo "switching to project: ${proj}"
	echo
	echo "project contents"
        cd "${PROJECTS_DIR}/${proj}"
	ls -l
}


# Export Functions


# Command Completion



