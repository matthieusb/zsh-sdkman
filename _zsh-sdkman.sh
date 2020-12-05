#compdef sdk

zstyle ':completion:*:descriptions' format '%B%d%b'

# TODO See if we keep the following "zstyle" lines (try and find their actual effect)
# zstyle ':completion::complete:sdk:*:commands' group-name commands
# zstyle ':completion::all_candidates:sdk:*:all_candidates' group-name all_candidates
# zstyle ':completion::candidates_to_uninstall:sdk:*:candidates_to_uninstall' group-name candidates_to_uninstall
# zstyle ':completion::complete:sdk::' list-grouped

########################################################
##### UTILITY FUNCTIONS
########################################################

# Gets candidate lists and removes all unecessery things just to get candidate names
__get_candidate_list() {
  local -a candidates_csv
  # Load the candidates from SDKMAN's candidates file, split at commas
  candidates_csv=$(<"${SDKMAN_DIR}/var/candidates")
  echo ${(s:,:)candidates_csv}
}

# Gets installed candidates list
__get_current_installed_list() {
  ( cd "$SDKMAN_DIR/candidates" && echo *(F) )
}

# Gets a candidate available versions (All of them, including already installed, not installed ...)
# Parameters:
# $1 chosen candidate label
__get_installed_candidate_all_versions() {
  local candidate=$1
  local candidate_dir="${ZSH_SDKMAN_CACHE}/candidates/$1"
  local versions_file="${candidate_dir}/versions"

  # Create cache directory if not present
  [[ ! -d "$candidate_dir" ]] && mkdir -p "$candidate_dir"
  # If file is not present or older than 12 hours, recreate cache file
  if [[ ! -e "$versions_file" || -n "$versions_file"(.mm+11N) ]]
  then
    local -a versions
    # The formatting of java is different from other outputs:
    if [[ "$candidate" = "java" ]]
    then
      # Get everything in the last column of the table, excluding the header.
      versions=( $(sdk list "$candidate" | grep '|' | cut -d\| -f6 | grep -v Identifier) )
    else
      # Replace special chars with spaces, break everything into newlines and clean it up.
      versions=( ${=$(sdk list "$candidate" | grep '^ ' | tr '+*>' '   ')} )
    fi
    # Save the versions to the cache file.
    echo $versions > "$versions_file"
  fi
  # Load list from cache file. (ZSH will sort it automatically.)
  echo $(<"$versions_file")
}

# Gets a candidate currently installed versions (the ones preceded by a "*")
# Parameters:
# $1: chosen candidate label
__get_installed_candidate_installed_versions() {
  local candidate_dir="${SDKMAN_DIR}/candidates/$1"
  ( [[ -d "$candidate_dir" ]] && cd "$candidate_dir" && echo *(F) )
}

# Gets versions of a candidate that are not yet installed
# Parameters:
# $1: chosen candidate label
__get_installed_candidate_not_installed_versions() {
  local candidate="$1"
  local -a installed=( $( __get_installed_candidate_installed_versions "$candidate" ) )
  local -a all=( $( __get_installed_candidate_all_versions "$candidate" ) )
  echo ${(@)all:|installed}
}

########################################################
##### FIRST ARG FUNCTIONS
########################################################

__describe_commands() {
  local -a commands
  commands=(
    'install: install a program'
    'uninstall: uninstal an existing program'
    'list: list all available packages or  '
    'use: change the version of an existing program'
    'default: set a program default version'
    'home: get the absolute path of a SDK'
    'env: manage .sdkmanrc configuration file'
    'current: display all programs current running version'
    'upgrade: upgrade all current programs or a particular one'
    'version: display current sdkman version'
    'broadcast: get the latest SDK release notifications'
    'help: display commands help'
    'offline: Toggle offline mode'
    'selfupdate: update sdkman itself'
    'update: refresh the candidate cache'
    'flush: flush sdkman local state'
  )

  _describe -t commands "Commands" commands && ret=0
}

########################################################
##### SECOND ARG FUNCTIONS
########################################################

# Displays ALL candidates available
# Parameters:
# $1: label to display
__describe_candidate_list() {
  local -a candidate_list
  candidate_list=( $( __get_candidate_list ) )
  _describe -t candidate_list $1 candidate_list && ret=0
}

# Displays installed candidates available
# Parameters:
# $1: label to display
__describe_current_installed_list() {
  local -a current_installed_list
  current_installed_list=( $( __get_current_installed_list ) )
  _describe -t current_installed_list $1 current_installed_list && ret=0
}

__describe_offline() {
  local -a offline

  offline=(
    'enable'
    'disable'
  )

  _describe -t offline "Offline" offline && ret=0
}

__describe_env() {
  local -a env=( 'init: Create a .sdkmanrc in the current directory' )
  _describe -t env "Environment creation" env && ret=0
}

########################################################
##### THIRD ARG FUNCTIONS
########################################################

# Parameters:
# $1: chosen candidate label
__describe_candidate_all_versions() {
  local -a installed_candidate_all_versions
  installed_candidate_all_versions=( $( __get_installed_candidate_all_versions $1 ) )
  _describe -t installed_candidate_all_versions "All versions for $1" installed_candidate_all_versions && ret=0
}

# Parameters:
# $1: chosen candidate label
__describe_candidate_installed_versions() {
  local -a installed_candidate_installed_versions
  installed_candidate_installed_versions=( $( __get_installed_candidate_installed_versions $1 ) )
  _describe -t installed_candidate_installed_versions "Installed versions for $1" installed_candidate_installed_versions && ret=0
}

# Parameters:
# $1: chosen candidate label
__describe_candidate_available_versions() {
  local -a installed_candidate_available_versions
  installed_candidate_available_versions=( $( __get_installed_candidate_not_installed_versions $1 ) )
  _describe -t installed_candidate_available_versions "Available (not installed) versions for $1" installed_candidate_available_versions && ret=0
}

########################################################
##### MAIN FUNCTION AND EXECUTION
########################################################

function _sdk() {
  local ret=1

  local target=$words[2]
  local candidate=$words[3]

  _arguments -C \
    '1: :->first_arg' \
    '2: :->second_arg' \
    '3: :->third_arg' \
    && ret=0

    case $state in
      first_arg)
        __describe_commands
        ;;
      second_arg)
        case $target in
          install)
            __describe_candidate_list "Candidates available for install"
            ;;
          list)
            __describe_candidate_list "Candidates available for version listing"
            ;;
          uninstall)
            __describe_current_installed_list "Candidates available for uninstall"
            ;;
          use)
            __describe_current_installed_list "Candidates available for usage"
            ;;
          default)
            __describe_current_installed_list "Candidates available for default setting"
            ;;
          home)
            __describe_current_installed_list "Candidates available for usage"
            ;;
          env)
            __describe_env
            ;;
          current)
            __describe_current_installed_list "Candidates available"
            ;;
          upgrade)
            __describe_current_installed_list "Candidates available for default setting"
            ;;
          offline)
            __describe_offline
            ;;
          *)
            ;;
        esac
        ;;
      third_arg)
        case $target in
          install)
            __describe_candidate_available_versions $candidate
            ;;
          uninstall)
            __describe_candidate_installed_versions $candidate
            ;;
          use)
            __describe_candidate_installed_versions $candidate
            ;;
          default)
            __describe_candidate_installed_versions $candidate
            ;;
          home)
            __describe_candidate_installed_versions $candidate
            ;;
          *)
            ;;
        esac
    esac

    return $ret
}

_sdk "$@"

# Local Variables:
# mode: Shell-Script
# sh-indentation: 2
# indent-tabs-mode: nil
# sh-basic-offset: 2
# End:
# vim: ft=zsh sw=2 ts=2 et
