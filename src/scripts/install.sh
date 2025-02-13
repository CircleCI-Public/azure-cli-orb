#!/usr/bin/env bash

install_debian() {

  # Set sudo to work whether logged in as root user or non-root user
  if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

  # https://github.com/CircleCI-Public/azure-cli-orb/issues/15
  # https://manpages.debian.org/unstable/apt/apt-get.8.en.html
  $SUDO apt-get --allow-releaseinfo-change-suite update && $SUDO apt-get -qqy install apt-transport-https

  if [[ $(command -v lsb_release) == "" ]]; then
    echo "Installing lsb_release"
    $SUDO apt-get -qqy install lsb-release
  fi

  # Create an environment variable for the correct distribution
  AZ_REPO="$(lsb_release -cs)"
  export AZ_REPO

  # Modify your sources list
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    $SUDO tee /etc/apt/sources.list.d/azure-cli.list

  if [[ $(command -v curl) == "" ]]; then
    echo "Installing curl"
    $SUDO apt-get -qqy install curl
  fi

  if [[ $(command -v gpg) == "" ]]; then
    echo "Installing gpg"
    $SUDO apt-get -qqy install gnupg
  fi

  # Get the Microsoft signing key
  echo "Install Microsoft signing key"
  curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    $SUDO tee /etc/apt/trusted.gpg.d/microsoft.gpg >/dev/null

  # Update and install the Azure CLI
  # https://github.com/CircleCI-Public/azure-cli-orb/issues/15
  # https://manpages.debian.org/unstable/apt/apt-get.8.en.html
  echo "Run apt-get update"
  $SUDO apt-get --allow-releaseinfo-change-suite update
  echo "Run apt-get install"
  $SUDO apt-get -qqy install \
    ca-certificates \
    azure-cli
  echo "Azure CLI is now installed."
}

install_alpine() {

}

# Verify the CLI isn't already installed
if az -v >/dev/null; then
  echo "Azure CLI installed already."
  exit 0
fi

if grep debian /etc/os-release &>/dev/null; then
  install_debian
  exit 0
fi

if grep alpine /etc/os-release &>/dev/null; then
  install_alpine
  exit 0
fi

echo "Could not identify the system properly so azure cli could not be installed"
exit 1
