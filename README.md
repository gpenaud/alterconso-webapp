```

   ______                 __  __                   _       __     __                    
  / ____/___ _____ ____  / /_/ /____              | |     / /__  / /_  ____ _____  ____
 / /   / __ `/ __ `/ _ \/ __/ __/ _ \   ______    | | /| / / _ \/ __ \/ __ `/ __ \/ __ \
/ /___/ /_/ / /_/ /  __/ /_/ /_/  __/  /_____/    | |/ |/ /  __/ /_/ / /_/ / /_/ / /_/ /
\____/\__,_/\__, /\___/\__/\__/\___/              |__/|__/\___/_.___/\__,_/ .___/ .___/
           /____/                                                        /_/   /_/      

```

<p align="center">
  <i>Cagette</i> provides an easy-to-use way for local organic food producers to sell their products to local consumers .
</p>

<p align="center">
  <a href="#overview">Overview</a> •
  <a href="#installing">Install</a> •
  <a href="#example">Example</a> •
  <a href="#running">Run</a> •
  <a href="#usage">Usage</a> •
  <a href="#change-log">Changelog</a> •
  <a href="#contributing">Contributing</a>
</p>

---

# Overview

[LocalStack 💻](https://localstack.cloud) is a cloud service emulator that runs in a single container on your laptop or in your CI environment. With LocalStack, you can run your AWS applications or Lambdas entirely on your local machine without connecting to a remote cloud provider! Whether you are testing complex CDK applications or Terraform configurations, or just beginning to learn about AWS services, LocalStack helps speed up and simplify your testing and development workflow.

LocalStack supports a growing number of AWS services, like AWS Lambda, S3, Dynamodb, Kinesis, SQS, SNS, and **many** more! The [**Pro version** of LocalStack](https://localstack.cloud/pricing) supports additional APIs and advanced features. You can find a comprehensive list of supported APIs on our [☑️ Feature Coverage](https://docs.localstack.cloud/aws/feature-coverage/) page.

LocalStack also provides additional features to make your life as a cloud developer easier! Check out LocalStack's [Cloud Developer Tools](https://docs.localstack.cloud/tools/) for more information.

## Requirements

* `python` (Python 3.6 up to 3.10 supported)
* `pip` (Python package manager)
* `Docker`

## Installing

The easiest way to install LocalStack is via `pip`:

```
pip install localstack
```

**Note**: Please do **not** use `sudo` or the `root` user - LocalStack should be installed and started entirely under a local non-root user. If you have problems with permissions in macOS High Sierra, install with `pip install --user localstack`

It installs the `localstack-cli` which is used to run the Docker image that hosts the LocalStack runtime.

## Example

Start LocalStack inside a Docker container by running:

```
 % localstack start -d

     __                     _______ __             __
    / /   ____  _________ _/ / ___// /_____ ______/ /__
   / /   / __ \/ ___/ __ `/ /\__ \/ __/ __ `/ ___/ //_/
  / /___/ /_/ / /__/ /_/ / /___/ / /_/ /_/ / /__/ ,<
 /_____/\____/\___/\__,_/_//____/\__/\__,_/\___/_/|_|

 💻 LocalStack CLI 0.14.3

[20:22:20] starting LocalStack in Docker mode 🐳
[20:22:21] detaching
```

You can query the status of respective services on LocalStack by running:

```
% localstack status services
┏━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┓
┃ Service                  ┃ Status      ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━┩
│ acm                      │ ✔ available │
│ apigateway               │ ✔ available │
│ cloudformation           │ ✔ available │
│ cloudwatch               │ ✔ available │
│ config                   │ ✔ available │
│ dynamodb                 │ ✔ available │
...
```

To use SQS, a fully managed distributed message queuing service, on LocalStack run:

```shell
% awslocal sqs create-queue --queue-name sample-queue
{
    "QueueUrl": "http://localhost:4566/000000000000/sample-queue"
}
```

Learn more about [LocalStack AWS services](https://docs.localstack.cloud/aws/) and using them with LocalStack's `awslocal` CLI.

## Running

You can run LocalStack through the following options:

- [LocalStack CLI](https://docs.localstack.cloud/get-started/#localstack-cli)
- [Docker](https://docs.localstack.cloud/get-started/#docker)
- [Docker Compose](https://docs.localstack.cloud/get-started/#docker-compose)
- [Helm](https://docs.localstack.cloud/get-started/#helm)

## Usage

To start using LocalStack, check out our documentation on [docs.localstack.cloud](https://docs.localstack.cloud).

- [LocalStack Configuration](https://docs.localstack.cloud/localstack/configuration/)
- [LocalStack in CI](https://docs.localstack.cloud/ci/)
- [LocalStack Integrations](https://docs.localstack.cloud/integrations/)
- [LocalStack Tools](https://docs.localstack.cloud/tools/)
- [Understanding LocalStack](https://docs.localstack.cloud/localstack/)
- [Troubleshoot](doc/troubleshoot/README.md)

To use LocalStack with a graphical user interface, you can use the following UI clients:

* [Commandeer desktop app](https://getcommandeer.com)
* [DynamoDB Admin Web UI](https://www.npmjs.com/package/dynamodb-admin)

## Change Log

Please refer to [`CHANGELOG.md`](CHANGELOG.md) to see the complete list of changes for each release.

## Contributing

If you are interested in contributing to LocalStack:

- Start by reading our [contributing guide](CONTRIBUTING.md).
- Check out our [developer guide](https://docs.localstack.cloud/developer-guide/).
- Look through our [roadmap](https://roadmap.localstack.cloud/).
- Navigate our codebase and [open issues](https://github.com/localstack/localstack/issues).

We are thankful for all the contributions and feedback we receive.

### Contributors

We are thankful to all the people who have contributed to this project.

<a href="https://github.com/localstack/localstack/graphs/contributors"><img src="https://opencollective.com/localstack/contributors.svg?width=890" /></a>

### Backers

We are also grateful to all our backers who have donated to the project. You can become a backer on [Open Collective](https://opencollective.com/localstack#backer).

<a href="https://opencollective.com/localstack#backers" target="_blank"><img src="https://opencollective.com/localstack/backers.svg?width=890"></a>

### Sponsors

You can also support this project by becoming a sponsor on [Open Collective](https://opencollective.com/localstack#sponsor). Your logo will show up here along with a link to your website.

<a href="https://opencollective.com/localstack/sponsor/0/website" target="_blank"><img src="https://opencollective.com/localstack/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/localstack/sponsor/1/website" target="_blank"><img src="https://opencollective.com/localstack/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/localstack/sponsor/2/website" target="_blank"><img src="https://opencollective.com/localstack/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/localstack/sponsor/3/website" target="_blank"><img src="https://opencollective.com/localstack/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/localstack/sponsor/4/website" target="_blank"><img src="https://opencollective.com/localstack/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/localstack/sponsor/5/website" target="_blank"><img src="https://opencollective.com/localstack/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/localstack/sponsor/6/website" target="_blank"><img src="https://opencollective.com/localstack/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/localstack/sponsor/7/website" target="_blank"><img src="https://opencollective.com/localstack/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/localstack/sponsor/8/website" target="_blank"><img src="https://opencollective.com/localstack/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/localstack/sponsor/9/website" target="_blank"><img src="https://opencollective.com/localstack/sponsor/9/avatar.svg"></a>

## License

Copyright (c) 2017-2021 LocalStack maintainers and contributors.

Copyright (c) 2016 Atlassian and others.

This version of LocalStack is released under the Apache License, Version 2.0 (see LICENSE.txt). By downloading and using this software you agree to the [End-User License Agreement (EULA)](doc/end_user_license_agreement). To know about the external software we use, look at our [third party software tools](doc/third-party-software-tools/README.md) page.
