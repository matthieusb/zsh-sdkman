#! /usr/bin/zsh

testEquality() {
  assertEquals 1 1
}

testJavaCandidates() {
  dockerize -wait file:///root/.zsh-sdkman/candidates/java/installed-candidates -timeout 300s
  sleep 2
  candidates=`cat ~/.zsh-sdkman/candidates/java/installed-candidates`
  assertEquals '11.0.1-open' "${candidates}"
}

testMavenCandidates() {
  dockerize -wait file:///root/.zsh-sdkman/candidates/maven/installed-candidates -timeout 300s
  sleep 2
  candidatesFirst=`cat ~/.zsh-sdkman/candidates/maven/installed-candidates | head -n 1`
  assertEquals '3.5.0' "${candidatesFirst}"
  candidatesSecond=`cat ~/.zsh-sdkman/candidates/maven/installed-candidates | tail -n 1`
  assertEquals '3.3.9' "${candidatesSecond}"
}

. ./shunit/shunit2
