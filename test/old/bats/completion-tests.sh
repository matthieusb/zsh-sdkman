#!/usr/bin/zsh

setup() {
  bats_load_library bats-support
  bats_load_library bats-assert

  # Mock zstyle
  mock_zstyle() {
    echo "zstyle invocation"
  }
  alias zstyle=mock_zstyle

  # Source the completion script
  source ../_zsh-sdkman.sh
}


@test "Test simple completion" {
  COMP_LINE="sdk --"
  COMP_POINT=${#COMP_LINE}
  COMP_WORDS=("sdk" "--")
  COMP_CWORD=1

#  run bash -c 'compgen -W "--help --version" -- "${COMP_WORDS[COMP_CWORD]}"'
  run _sdk
  [ "$status" -eq 0 ]
  [[ "$output" == *"--help"* ]]
  [[ "$output" == *"--version"* ]]
}