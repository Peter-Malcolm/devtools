# devtools
# entrypoint for devtools intended to provide a single path for installing

# Get the directory of the current script.
# warning: this may be bash specific but works with
# both source and direct execution of the script.
project_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))


# import venvs
source "${project_dir}/venvtools.sh"


# import projects
source "${project_dir}/projtools.sh"
