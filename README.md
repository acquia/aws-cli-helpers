# AWS CLI Helpers

[![Build Status](https://travis-ci.com/acquia/aws-cli-helpers.svg?token=PH71WkhMufTnsVvCU5rV&branch=master)](https://travis-ci.com/acquia/aws-cli-helpers)

This repository contains a series of bash functions that make working with the
[AWS CLI tool](https://aws.amazon.com/cli/) easier.

## Installation

Clone this repository or download the source code, then source the
`aws-cli-helpers` file in your bash script:

```shell
#!/usr/bin/env bash

. /path/to/aws-cli-helpers
```

## Usage

#### Filters

Many AWS commands accept the `--filters` option. This option is equally a pain
in the ass as it is powerful. The functions in this library make it easier to
create filters. Assuming that the output of the filter functions in the examples
are captured in the `$FILTERS` variable, they can be used in `aws` commands:

```shell
aws ec2 describe-instances --filters $FILTERS
```

##### Simple filters

Create a simple filter, for example running instances.

```shell
filter "instance-state-name" "running"`
```

... which evaluates to:

```
Name=instance-state-name,Values="running"
```

##### Complex, predefined filters

Filter for running EC2 instances in a CloudFormation stack by resource:

```shell
logical_id_ec2_filter "my-stack" "MyResource"
```

... which evaluates to:

```
Name=instance-state-name,Values="running" Name=tag-key,Values="aws:cloudformation:stack-name" Name=tag-value,Values="my-stack" Name=tag-key,Values="aws:cloudformation:logical-id" Name=tag-value,Values="MyResource"
```

#### Resource IDs

Use the `resource_id_from_logical_id` function to get the resource's unique ID
given a CloudFormation stack name and resource ID.

```shell
resource_id_from_logical_id "my-stack" "MyResource"
```

If, for example, the resource is an RDS database, the output will be the "DB
Instance Identifier".

#### Public IP addresses

Use the `ips_from_logical_id` function output the public IP addresses for EC2
instances in a CloudFormation stack associated with a resource that are running.

```shell
ips_from_logical_id "my-stack" "MyResource"
```

#### Image IDs

Use the `amis_from_logical_id` function output the unique image IDs that EC2
instances in a CloudFormation stack associated with a resource ID were launched
from.

```shell
amis_from_logical_id "my-stack" "MyResource"
```

## Contributing

Pull requests are welcome. Please follow [Google's Shell Style Guide](https://google.github.io/styleguide/shell.xml).
Make a best effort to write tests. We use the [Bash Automated Testing System](https://github.com/sstephenson/bats) (bats).
