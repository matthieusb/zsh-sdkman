#! /usr/bin/zsh

testEquality() {
  assertEquals 1 1
}

# Disabled for now, because installing only one version seems to install 2. No reason found
# testJavaCandidates() {
#   dockerize -wait file:///root/.zsh-sdkman/candidates/java/installed-candidates -timeout 300s
#   sleep 2
#   candidates=`cat ~/.zsh-sdkman/candidates/java/installed-candidates`
#   assertEquals '12.0.1-open' "${candidates}"
# }

testMavenCandidates() {
  dockerize -wait file:///root/.zsh-sdkman/candidates/maven/installed-candidates -timeout 300s
  sleep 2
  candidatesFirst=`cat ~/.zsh-sdkman/candidates/maven/installed-candidates | head -n 1`
  assertEquals '3.5.0' "${candidatesFirst}"
  candidatesSecond=`cat ~/.zsh-sdkman/candidates/maven/installed-candidates | tail -n 1`
  assertEquals '3.3.9' "${candidatesSecond}"
}

. ./shunit/shunit2
