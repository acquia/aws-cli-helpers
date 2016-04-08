#!/usr/bin/env bats

load aws-cli-helpers

@test "exit with an error message" {
  run exit_err "error message"
  [ "$status" -eq 1 ]
  [[ "$output" =~ "error message" ]]

  run exit_err "error message 2"
  [ "$status" -eq 1 ]
  [[ "$output" =~ "error message 2" ]]
}

@test "exit with an error message and a status code" {
  run exit_err "a" "complex error message" 3
  [ "$status" -eq 3 ]
}

@test "check that an argument exists" {
  run check_arg "arg1"
  [ "$status" -eq 0 ]
}

@test "check that a missing argument exits with an error message" {
  run check_arg ""
  [ "$status" -eq 1 ]
  [[ "$output" =~ "function missing required argument" ]]
}

@test "check that a missing argument exits with a custom error message" {
  run check_arg "" "error message"
  [ "$status" -eq 1 ]
  [[ "$output" =~ "error message" ]]
}

@test "check that a missing argument exits with a custom error message and exit status" {
  run check_arg "" "error message" 2
  [ "$status" -eq 2 ]
  [[ "$output" =~ "error message" ]]
}
