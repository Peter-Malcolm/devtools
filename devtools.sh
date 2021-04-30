
# Current dir
# warning: this may be bash specific but works with
# both source and direct execution of the script.
project_dir=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

# venvs
source "${project_dir}/venvtools.sh"

# projects
source "${project_dir}/projtools.sh"
