# --------------------------
# -------- Aliases
# --------------------------
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
SDKMAN_DIR_LOCAL=~/.sdkman

# Custom variables for later
# TODO: add a specific folder and move everything in it
export ZSH_SDKMAN_CANDIDATE_LIST_HOME=~/.zsh-sdkman.candidate-list
export ZSH_SDKMAN_INSTALLED_LIST_HOME=~/.zsh-sdkman.current-installed-list

########################################################
##### UTILITY FUNCTIONS
########################################################

_sdkman_get_candidate_list() {
  (sdk list | grep --color=never  "$ sdk install" | sed 's/\$ sdk install //g' | sed -e 's/[\t ]//g;/^$/d' > $ZSH_SDKMAN_CANDIDATE_LIST_HOME &)
}

_sdkman_get_current_installed_list() {
  (sdk current | sed "s/Using://g" | sed "s/\:.*//g"  | sed -e "s/[\t ]//g;/^$/d" > $ZSH_SDKMAN_INSTALLED_LIST_HOME &)
}

########################################################
##### MAIN EXECUTION
########################################################

# TODO: Add the candidate version files creation to correct the bugs with the third arg

# "sdk" command is not found if we don't do this
source "$SDKMAN_DIR_LOCAL/bin/sdkman-init.sh"

# Initialize files with available candidate list and currently installed candidates
# TODO Mutualize everything in another function
_sdkman_get_candidate_list "$@"
_sdkman_get_current_installed_list "$@"
