# Azure CLI Orb  [![CircleCI status](https://circleci.com/gh/CircleCI-Public/azure-cli-orb.svg "CircleCI status")]

A CircleCI Orb to install and log into the Azure CLI

## Features
This orb offers the ability to login via an Azure user both on its default tenant and an alternative tenant.
It also offers the ability to login via an Azure Service Principal.

### Commands
You may use the following commands provided by this orb directly from your own job.

- [**install**](#install) - Installs the Azure CLI on Debian based systems

- [**login-with-user**](#login-with-user) - Allows you to login to the Azure CLI with an Azure user.

- [**login-with-service-principal**](#login-with-service-principal) - Allows you to login to the Azure CLI with a Service Principal

#### `install`

##### Example

```yaml
version: 2.1

orbs:
  azure-cli: circleci/azure-cli@1.0.0

jobs:
  verify-install:
    docker:
      - image: circleci/python:2.7-stretch
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
| `alternate-tenant` | `boolean` | `false` | Set to True to use the --tenant az login option |
| `azure-tenant` | `env_var_name` | `AZURE_TENANT` | Environment variable storing your Azure tenant, necessary if `alternate-tenant` is set to true |

##### Example

```yaml
version: 2.1

orbs:
  azure-cli: circleci/azure-cli@1.0.0

jobs:
  login-to-azure:
    docker:
      - image: circleci/python:2.7-stretch
    steps:
      - azure-cli/install

      - azure-cli/login-with-user:
          alternate-tenant: true

      - run:
          name: List resources of tenant stored as `AZURE_TENANT` env var
          command: az resource list

workflows:
  example-workflow:
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
    docker:
      - image: circleci/python:2.7-stretch
    steps:
      - azure-cli/install

      - azure-cli/login-with-service-principal

      - run:
          name: List resources of tenant stored as `AZURE_SP_TENANT` env var
          command: az resource list

workflows:
  example-workflow:
    - login-to-azure
```
