# Azure CLI Orb  [![CircleCI status](https://circleci.com/gh/CircleCI-Public/azure-cli-orb.svg "CircleCI status")](https://circleci.com/gh/CircleCI-Public/azure-cli-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/circleci/azure-cli.svg)](https://circleci.com/orbs/registry/orb/circleci/azure-cli) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/CircleCI-Public/azure-cli-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

A CircleCI Orb to install and log into the Azure CLI

## Features
This orb offers the ability to login via an Azure user both on its default tenant and an alternative tenant.
It also offers the ability to login via an Azure Service Principal, using either a password or OIDC.

### Executors

#### `default`
Debian-based [`circleci/python` Docker image](https://hub.docker.com/r/circleci/python) to use

##### Parameters

| Parameter | type | default |
|-----------|------|---------|
| `python-version` | `string` | `2.7` |
| `debian-release` | `string` | `stretch` |

#### `azure-docker`
Microsoft's [Azure CLI Docker image](https://hub.docker.com/r/microsoft/azure-cli):

```yaml
docker:
  - image: mcr.microsoft.com/azure-cli
```

### Commands
You may use the following commands provided by this orb directly from your own job.

- [**install**](#install) - Installs the Azure CLI on Debian based systems

- [**login-with-user**](#login-with-user) - Allows you to login to the Azure CLI with an Azure user.

- [**login-with-service-principal**](#login-with-service-principal) - Allows you to login to the Azure CLI with a Service Principal

- [**login-with-oidc**](#login-with-oidc) - Allows you to login to the Azure CLI with a Service Principal using OIDC

- [**login-with-user-or-service-principal**](#login-with-user-or-service-principal) - Allows you to login to the Azure CLI, where the login type (user/Service Principal) is determined based on detection of the relevant environment variables.

#### `install`

##### Example

```yaml
version: 2.1

orbs:
  azure-cli: circleci/azure-cli@1.0.0

jobs:
  verify-install:
    executor: azure-cli/default
    steps:
      - azure-cli/install

      - run:
          name: Verify Azure CLI is installed
          command: az -v

workflows:
  example-workflow:
    jobs:
      - verify-install
```

#### `login-with-user`

##### Parameters

| Parameter | type | default | description |
|-----------|------|---------|-------------|
| `azure-username` | `env_var_name` | `AZURE_USERNAME` | Environment variable storing your Azure username |
| `azure-password` | `env_var_name` | `AZURE_PASSWORD` | Environment variable storing your Azure password |
| `alternate-tenant` | `boolean` | `false` | Set to True to use the `--tenant az` login option |
| `azure-tenant` | `env_var_name` | `AZURE_TENANT` | Environment variable storing your Azure tenant, necessary if `alternate-tenant` is set to true |

##### Example

```yaml
version: 2.1

orbs:
  azure-cli: circleci/azure-cli@1.0.0

jobs:
  login-to-azure:
    executor: azure-cli/default
    steps:
      - azure-cli/install

      - azure-cli/login-with-user:
          alternate-tenant: true

      - run:
          name: List resources of tenant stored as `AZURE_TENANT` env var
          command: az resource list

workflows:
  example-workflow:
    jobs:
      - login-to-azure
```

#### `login-with-service-principal`

##### Parameters

| Parameter | type | default | description |
|-----------|------|---------|-------------|
| `azure-sp` | `env_var_name` | `AZURE_SP` | Name of environment variable storing the full name of the Service Principal, in the form `http://app-url` |
| `azure-sp-password` | `env_var_name` | `AZURE_SP_PASSWORD` | Name of environment variable storing the password for the Service Principal |
| `azure-sp-tenant` | `env_var_name` |  `AZURE_SP_TENANT` | Name of environment variable storing the tenant ID for the Service Principal |

##### Example

```yaml
version: 2.1

orbs:
  azure-cli: circleci/azure-cli@1.0.0

jobs:
  login-to-azure:
    executor: azure-cli/azure-docker
    steps:
      - azure-cli/login-with-service-principal

      - run:
          name: List resources of tenant stored as `AZURE_SP_TENANT` env var
          command: az resource list

workflows:
  example-workflow:
    jobs:
      - login-to-azure
```

#### `login-with-oidc`

##### Parameters

| Parameter | type | default | description |
|-----------|------|---------|-------------|
| `azure-sp` | `env_var_name` | `AZURE_SP` | Name of environment variable storing the full name of the Service Principal, in the form `http://app-url` |
| `azure-sp-tenant` | `env_var_name` |  `AZURE_SP_TENANT` | Name of environment variable storing the tenant ID for the Service Principal |

##### Example

```yaml
version: 2.1

orbs:
  azure-cli: circleci/azure-cli@1.0.0

jobs:
  login-to-azure:
    executor: azure-cli/azure-docker
    steps:
      - azure-cli/login-with-oidc

      - run:
          name: List resources of tenant stored as `AZURE_SP_TENANT` env var
          command: az resource list

workflows:
  example-workflow:
    jobs:
      - login-to-azure
```

#### `login-with-user-or-service-principal`

##### Parameters

| Parameter | type | default | description |
|-----------|------|---------|-------------|
| `azure-username` | `env_var_name` | `AZURE_USERNAME` | Environment variable storing your Azure username. Only applicable for user logins. |
| `azure-password` | `env_var_name` | `AZURE_PASSWORD` | Environment variable storing your Azure password. Only applicable for user logins. |
| `alternate-tenant` | `boolean` | `false` | Set to True to use the `--tenant az` login option. Only applicable for user logins. |
| `azure-tenant` | `env_var_name` | `AZURE_TENANT` | Environment variable storing your Azure tenant, necessary if `alternate-tenant` is set to true. Only applicable for user logins. |
| `azure-sp` | `env_var_name` | `AZURE_SP` | Name of environment variable storing the full name of the Service Principal, in the form `http://app-url`. Only applicable for Service Principal logins. |
| `azure-sp-password` | `env_var_name` | `AZURE_SP_PASSWORD` | Name of environment variable storing the password for the Service Principal. Only applicable for Service Principal logins. |
| `azure-sp-tenant` | `env_var_name` |  `AZURE_SP_TENANT` | Name of environment variable storing the tenant ID for the Service Principal. Only applicable for Service Principal logins. |

##### Example

```yaml
description: >
  Log into Azure with the login type determined based on
  environment variable detection.

usage:
  version: 2.1

  orbs:
    azure-cli: circleci/azure-cli@1.0.0

  jobs:
    login-to-azure:
      executor: azure-cli/azure-docker
      steps:
        - azure-cli/login-with-user-or-service-principal

        - run:
            name: List resources of tenant stored as `AZURE_SP_TENANT` env var
            command: az resource list

  workflows:
    example-workflow:
      jobs:
        - login-to-azure
```
