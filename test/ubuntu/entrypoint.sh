#!/usr/bin/zsh

zsh
sdk-refresh-completion-files
dockerize -wait file:///root/.zsh-sdkman/candidates/maven/installed-candidates -timeout 300s
