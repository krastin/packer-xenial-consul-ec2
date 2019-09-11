# packer-xenial-consul-ec2
An EC2 AMI based on ubuntu xenial with Consul

# Purpose

This repository attempts to store the minimum amount of code that is required to create a:
- Ubuntu Xenial64 box
- With Hashicorp's Consul
- using Packer
- for Amazon AWS EC2

# Prerequisites
## Install packer
Grab packer and learn how to install it from [here](https://www.packer.io/intro/getting-started/install.html).

## Install aws-cli
Grab aws-cli and learn how to install it from [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html).

## Install kitchen
Use the following instructions as a guidance. Different steps might have to be used ultimately.

### Install rbenv
<details>
  <summary>Install on MacOS</summary>

  ```
  brew install rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
rbenv init
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
  ```
</details>

<details>
  <summary>Install on Linux</summary>
  
  ```
apt update
apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
wget -q https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer -O- | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
rbenv init
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
  ```
</details>

### Install Ruby Gems
```
rbenv install 2.4.6
rbenv local 2.4.6
rbenv versions
gem install bundler
bundle install
```

### Have Kitchen tests use your own AWS account
In order for kitchen to know where to create the testing node instance, modify the following parameters in the _.kitchen.yml_ file:
- shared_credentials_profile
- aws_ssh_key_id
- ssh_key
- owner-id

The parameters should make sense for people familiar with AWS.

# How to build the AWS AMI

    packer build template.json

# How to test
    bundle exec kitchen test

<details>
  <summary>Separate steps when further troubleshooting is needed</summary>

  ````
bundle exec kitchen converge # create testing resource
bundle exec kitchen verify # run tests
bundle exec kitchen destroy # destroy testing resource
  ````
</details>

# To Do
- [ ] add consul provisioning script

# Done
- [x] build initial box
