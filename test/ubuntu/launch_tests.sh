#! /usr/bin/zsh

echo '### Launching tests scripts ###'

echo '### Generating candidates files through zsh-sdkman plugin ###'
/usr/bin/zsh -c "source ~/.zshrc && sdk-refresh-completion-files"

echo '### Launching shunit2 tests ###'
export SHUNIT_PARENT="candidates_tests.sh"
zsh -o shwordsplit -- candidates_tests.sh
