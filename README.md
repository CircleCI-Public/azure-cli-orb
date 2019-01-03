# azure-cli Orb
TODO: Status Badge

A CircleCI Orb to install and login to the Azure CLI

## Features
This orb offers the ability to login via an Azure user both on its default tenant and an alternative tenant.
It also offers the ability to login via an Azure Service Principal.

### Commands
You may use the following commands provided by this orb directly from your own job.

- [**install**](#install) - Installs the Azure CLI on Debian based systems

- [**login-with-user**](#login-with-user) - Allows you to login to the Azure CLI with an Azure user.

- [**login-with-service-principal**](#login-with-service-principal) - Allows you to login to the Azure CLI with a Service Principal

#### install

##### Parameters

| Parameter         | type    | default  |     description |
|------------------|--------|-------------|----------------|
|         |   |     |  | 

##### Example

```
version: 2.1

orbs:
  azure-cli: circleci/azure-cli@0.0.1

jobs:
  verify-install:  
    docker:
      - image: circleci/python:2.7-stretch
    steps:
      - azure-cli/install
      - run:
        command: az -v
        name: Verify Azure CLI is installed
workflows:
  example-workflow:
    jobs:
      - verify-install
```


#### login-with-user 

##### Parameters

| Parameter         | type    | default  |     description |
|------------------|--------|-------------|----------------|
| azure-username        | string  | $AZURE_USERNAME    | Username of Azure user to login with  | 
| azure-password   | string  | $AZURE_PASSWORD  | The password of the Azure user to login with |
| azure-tenant      | string   |  $AZURE_TENANT  | Tenant to login to. Only used if "alternate-tenant" is set to true |
| alternate-tenant   | boolean  | false  | Set to True to use the --tenant az login option |

##### Example

```
version: 2.1
orbs:
    azure-cli: circleci/azure-cli@0.0.1
jobs:
    login-to-azure:
        docker: 
            - image: circleci/python:2.7-stretch
        steps:
          - azure-cli/login-with-user:
              alternate-tenant: true
              azure-tenant: $AZURE_EXAMPLE_TENANT
          - run: 
                name: List resources of $AZURE_EXAMPLE_TENANT
                command: az resource list 
workflows:
    install-login-list:
        - azure-cli/install
        - login-to-azure:
            requires:
                - azure-cli/install
```

#### login-with-service-principal 

##### Parameters

| Parameter         | type    | default  |     description |
|------------------|--------|-------------|----------------|
| azure-username        | string  | $AZURE_USERNAME    | Name of Azure Service Principal to login with  | 
| azure-password   | string  | $AZURE_PASSWORD  | The password of the Azure Service Principal to login with |
| azure-tenant      | string   |  $AZURE_TENANT  | Tenant to login to |

##### Example

```
version: 2.1
orbs:
    azure-cli: circleci/azure-cli@0.0.1
jobs:
    login-to-azure:
        docker: 
            - image: circleci/python:2.7-stretch
        steps:
          - azure-cli/login-with-service-principal:
              azure-tenant: $AZURE_EXAMPLE_TENANT
          - run: 
                name: List resources of $AZURE_EXAMPLE_TENANT
                command: az resource list 
workflows:
    install-login-list:
        - azure-cli/install
        - login-to-azure:
            requires:
                - azure-cli/install

```
