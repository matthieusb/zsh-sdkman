#compdef sdk

zstyle ':completion:*:descriptions' format '%B%d%b'

# TODO See if we keep the following "zstyle" lines (try and find their actual effect)
# zstyle ':completion::complete:sdk:*:commands' group-name commands
# zstyle ':completion::all_candidates:sdk:*:all_candidates' group-name all_candidates
# zstyle ':completion::candidates_to_uninstall:sdk:*:candidates_to_uninstall' group-name candidates_to_uninstall
# zstyle ':completion::complete:sdk::' list-grouped

# Gets candidate lists and removes all unecessery things just to get candidate names
__get_candidate_list() {
  cat $ZSH_SDKMAN_CANDIDATE_LIST_HOME
}

# Gets installed candidates list
__get_current_installed_list() {
  cat $ZSH_SDKMAN_INSTALLED_LIST_HOME
}

__describe_commands() {
  local -a commands
  commands=(
    'install: install a program'
    'uninstall: uninstal an existing program'
    'list: list all available packages or  '
    'use: change the version of an existing program'
    'default: set a program default version'
    'current: display all programs current running version'
    'upgrade: upgrade all current programs or a particular one'
    'version: display current sdkman version'
    'broadcast: get the latest SDK release notifications'
    'help: display commands help'
    'offline: Toggle offline mode'
    'selfupdate: update sdkman itself'
    'flush: flush sdkman local state'
  )

  _describe -t commands "Commands" commands && ret=0
}

__describe_install() {
  local -a candidate_list_install
  candidate_list_install=( $( __get_candidate_list ) )
  _describe -t candidate_list_install "Candidates available for install" candidate_list_install && ret=0
}

__describe_uninstall() {
  local -a candidates_to_uninstall
  candidates_to_uninstall=( $( __get_current_installed_list ) )
  _describe -t candidates_to_uninstall "Candidates to uninstall" candidates_to_uninstall && ret=0
}

__describe_list() {
  sdk current && ret=0

  # local -a candidate_list
  # candidate_list=( $( __get_current_installed_list ) )
  # _describe -t candidate_list "Candidates available for version listing" candidate_list && ret=0
}

# TODO Add describe use when candidate is selected
__describe_use() {
  local -a candidate_list_use
  candidate_list_use=( $( __get_current_installed_list ) )
  _describe -t candidate_list_use "Candidates available for usage" candidate_list_use && ret=0
}

__describe_default() {
  # TODO
}

__describe_current() {
  # TODO
}

__describe_upgrade() {
  # TODO
}

__describe_offline() {
  local -a offline

  offline=(
    'enabled'
    'disabled'
  )

  _describe -t offline "Offline" offline && ret=0
}

function _sdk() {
  local ret=1

  local target=$words[2]
  local candidate=$word[3]

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
            __describe_install
            ;;
          uninstall)
            __describe_uninstall
            ;;
          list)
            __describe_list
            ;;
          use)
            __describe_use
            ;;
          default)
            __describe_default
            ;;
          current)
            __describe_current
            ;;
          upgrade)
            __describe_upgrade
            ;;
          offline)
            __describe_offline
            ;;
          *)
            ;;
        esac
        ;;
      third_arg)
        case $candidate in
          *)
            echo "Work in progess"
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
