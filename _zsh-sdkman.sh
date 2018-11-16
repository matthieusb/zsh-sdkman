#compdef sdk

# TODO Should this be activated or not ?
# zstyle ':completion:*:descriptions' format '%B%d%b'
# zstyle ':completion::complete:sdk:*:commands' group-name commands
# zstyle ':completion::complete:sdk::' list-grouped

# zmodload zsh/mapfile

# TODO Add a plugin file to add aliases

_describe_commands() {
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

_describe_offline() {
  local -a offline

  offline=(
    'enabled: sdkman wo'
    'disabled'
  )

  _describe -t offline "Offline" offline && ret=0
}

function _sdk() {
  local ret=1

  local target=$words[2]

  # TODO There should be more arguments here
  _arguments -C \
    '1: :->first_arg' \
    '2: :->second_arg' && ret=0

    case $state in
      first_arg)
        _describe_commands
        ;;
      second_arg)
        case $target in
          offline)
            _describe_offline
            ;;
          *)
            ;;
        esac
        ;;
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
