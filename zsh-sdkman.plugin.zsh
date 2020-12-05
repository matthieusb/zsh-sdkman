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

export ZSH_SDKMAN_CACHE="$ZSH_SDKMAN_DIR_LOCAL"

########################################################
##### FOLDER MANAGEMENT
########################################################

# Creates folders necessary to work with the plugin
__init_plugin_folder() {
  mkdir -p $ZSH_SDKMAN_DIR_LOCAL
  mkdir -p $ZSH_SDKMAN_CANDIDATES_HOME
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


# Manual command to be used by the users for troubleshooting
sdk-refresh-completion-files() {
  _init_zsh-sdkman_plugin
}
