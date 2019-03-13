#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

# Uncomment to enable stub debugging
# export AZ_STUB_DEBUG=/dev/tty

@test "calls az login " {
  export BUILDKITE_PLUGIN_AZURE_LOGIN_USE_IDENTITY=false

  stub az "login --verbose : echo logging in to Azure"

  run $PWD/hooks/pre-command

  assert_output --partial "logging in to Azure"
  assert_success
  
  unstub az
  unset BUILDKITE_PLUGIN_AZURE_LOGIN_USE_IDENTITY
}

@test "calls az login with --identity" {
  export BUILDKITE_PLUGIN_AZURE_LOGIN_USE_IDENTITY=true

  stub az "login --verbose --identity : echo logging into Azure with identity"

  run $PWD/hooks/pre-command

  assert_output --partial "logging into Azure with identity"
  assert_success
  
  unstub az
  unset BUILDKITE_PLUGIN_AZURE_LOGIN_USE_IDENTITY
}