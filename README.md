# AWS CLI Helpers

...

## Installation

...

## Usage

#### Filters

Many AWS commands accept the `--filters` option. This is equally as powerful as
it is a pain in the ass. The functions in this library make it easier to create
filters.

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

.. evaluates to:

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
Name=instance-state-name,Values="running" Name=tag-key,Values="aws:cloudformation:stack-name" Name=tag-value,Values="my-stack" Name=tag-key,Values="aws:cloudformation:logical-id" Name=tag-value,Values="AutoScalingGroupElasticsearch"
```
