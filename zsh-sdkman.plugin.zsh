########################################################
##### ALIASES
########################################################
alias sdki='sdk install'
alias sdkun='sdk uninstall'
alias list='sdk list'
alias sdku='sdk use'
alias sdkd='sdk default'
alias sdkc='sdk current'
alias sdkup='sdk upgrade'
alias sdkv='sdk version'
alias sdkb='sdk broadcast'
alias sdko='sdk offline'
alias sdksu='sdk selfupdate'
alias sdkf='sdk flush'

# --------------------------
# -------- Executed on shell launch for completion help
# --------------------------
# NOTE: Sdkman seems to always output the candidate list rather than the currently installted list when we do this through the completion script
# There are two goals in the code below:
#   - Optimization: the _sdkman_get_candidate_list command can take time, so it is done once and in background
#   - Bug correction: correct the problem with sdkman command output explained above

########################################################
##### GLOBAL VARIABLES AND PATHS
########################################################

# WARNING: We are setting this as a local variable because we don't have it yet at the time of initialization
# A better approach would be welcome
SDKMAN_DIR_LOCAL=${SDKMAN_DIR:-$HOME/.sdkman}

# Custom variables for later in this script and in the completion script
ZSH_SDKMAN_DIR_LOCAL=${ZSH_SDKMAN_DIR:-$HOME/.zsh-sdkman}

export ZSH_SDKMAN_CANDIDATES_HOME=$ZSH_SDKMAN_DIR_LOCAL/candidates

export ZSH_SDKMAN_INSTALLED_CANDIDATES_FILE_NAME=installed-candidates
export ZSH_SDKMAN_NOT_INSTALLED_CANDIDATES_FILE_NAME=not-installed-candidates
export ZSH_SDKMAN_ALL_CANDIDATES_FILE_NAME=all-candidates

SDKMAN_LAST_REFRESH_TIMESTAMP_FILE=$ZSH_SDKMAN_DIR_LOCAL/last-refresh
TIMESTAMP_INTERVAL_IN_SECONDS=43200 # 12 hours

########################################################
##### FOLDER MANAGEMENT
########################################################

# Creates folders necessary to work with the plugin
__init_plugin_folder() {
  mkdir -p $ZSH_SDKMAN_DIR_LOCAL
  mkdir -p $ZSH_SDKMAN_CANDIDATES_HOME
}

########################################################
##### SDK COMMANDS
########################################################

# Gets a candidate available versions (All of them, including already installed, not installed ...)
# Parameters:
# $1 chosen candidate label
__get_installed_candidate_all_versions() {
  sdk list $1 | egrep --color=never -i -v ".*(local version|installed|currently in use).*" | egrep --color=never -v -i "Available .* Versions" | egrep --color=never -v "^=*$" | egrep --color=never -i -v ".*(sdk update|WARNING).*"
}

# Gets a candidate currently installed versions (the ones preceded by a "*")
# Parameters:
# $1: chosen candidate label
__get_installed_candidate_installed_versions() {
  __get_installed_candidate_all_versions $1 | egrep "\*" | sed 's/\*//g' | sed 's/>//g' | sed -e 's/[\t ]/\n/g;/^$/d' | awk 'NF > 0'
}

# Gets versions of a candidate that are not yet installed
# Parameters:
# $1: chosen candidate label
__get_installed_candidate_not_installed_versions() {
  __get_installed_candidate_all_versions $1 | egrep -v "\*" | sed 's/\*//g' | sed 's/>//g' | sed -e 's/[\t ]/\n/g;/^$/d' | awk 'NF > 0'
}

########################################################
##### PERIOD REFRESH FUNCTIONS
########################################################
__persist_current_timestamp_in_file() {
  date +%s > $SDKMAN_LAST_REFRESH_TIMESTAMP_FILE
}

########################################################
##### MAIN EXECUTION
########################################################

# "sdk" command is not found if we don't do this
source "$SDKMAN_DIR_LOCAL/bin/sdkman-init.sh"

# Initialize files with available candidate list and currently installed candidates
_init_zsh-sdkman_plugin() {
  __init_plugin_folder
}

# Only refreshes the file containing info for completion when:
# - It is first usage and those files aren't there
# - The files haven't been refreshed for at least 12 hours
_sdk-refresh-completion-files-auto() {
  if [ ! -f "$SDKMAN_LAST_REFRESH_TIMESTAMP_FILE" ] # File not found (First usage)
  then
      _init_zsh-sdkman_plugin
      __persist_current_timestamp_in_file
  else
    local -a previous_timestamp
    local -a current_timestamp
    local -a previous_timestamp_plus_2_hours

    previous_timestamp=`cat $SDKMAN_LAST_REFRESH_TIMESTAMP_FILE`
    previous_timestamp_plus_2_hours=$(($previous_timestamp + $TIMESTAMP_INTERVAL_IN_SECONDS))
    current_timestamp=`date +%s`

    if [ "$current_timestamp" -gt "$previous_timestamp_plus_2_hours" ]; then
      _init_zsh-sdkman_plugin
    fi
  fi
}

# Manual command to be used by the users for troubleshooting
sdk-refresh-completion-files() {
  _init_zsh-sdkman_plugin
}

_sdk-refresh-completion-files-auto
