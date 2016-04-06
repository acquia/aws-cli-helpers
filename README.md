# AWS CLI Helpers

This repository contains a series of bash functions that make it easier to work
with the [AWS CLI tool](https://aws.amazon.com/cli/).

## Installation

Clone this repository or download the source code. Source the `aws-cli-helpers`
fine in your bash script using the following snippet:

```shell
#!/usr/bin/env bash

. /path/to/aws-cli-helpers
```

## Usage

#### Filters

Many AWS commands accept the `--filters` option. This option is equally a pain
in the ass as it is powerful. The functions in this library make it easier to
create filters.

The following examples assume that the output is being stored in the `$FILTERS`
variable, and can therefore be used by running the following command:

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

Filter instances by resource in a CloudFormation stack:

```shell
logical_id_ec2_filter "my-stack" "MyResource"
```

... which evaluates to:

```
Name=instance-state-name,Values="running" Name=tag-key,Values="aws:cloudformation:stack-name" Name=tag-value,Values="my-stack" Name=tag-key,Values="aws:cloudformation:logical-id" Name=tag-value,Values="MyResource"
```

#### Public IP addresses

Use the `ips_from_logical_id` function output the public IP addresses for EC2
instances in a CloudFormation stack associated with a resource that are running.

```shell
ips_from_logical_id "my-stack" "MyResource"
```

## Contributing

Pull requests are welcome. Please follow [Google's Shell Style Guide](https://google.github.io/styleguide/shell.xml).
