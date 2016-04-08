#!/usr/bin/env bats

load aws-cli-helpers

@test "create a basic filter" {
  run filter "instance-state-name" "running"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Name=instance-state-name,Values=\"running\"" ]
}

@test "create a tag filter" {
  run tag_filter "my-tag" "my-value"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Name=tag-key,Values=\"my-tag\" Name=tag-value,Values=\"my-value\"" ]
}

@test "create a filter for arbitrary resources in a CloudFormation stack" {
  run logical_id_filter "my-stack" "MyResource"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Name=tag-key,Values=\"aws:cloudformation:stack-name\" Name=tag-value,Values=\"my-stack\" Name=tag-key,Values=\"aws:cloudformation:logical-id\" Name=tag-value,Values=\"MyResource\"" ]
}

@test "create a filter for EC2 instance resources in a CloudFormation stack" {
  run logical_id_ec2_filter "my-stack" "MyResource"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Name=instance-state-name,Values=\"running\" Name=tag-key,Values=\"aws:cloudformation:stack-name\" Name=tag-value,Values=\"my-stack\" Name=tag-key,Values=\"aws:cloudformation:logical-id\" Name=tag-value,Values=\"MyResource\"" ]
}
