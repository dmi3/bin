#!/bin/bash

#  Decription
#  ----------
#  * Writes all running AWS EC2 instances to [SSH config file](https://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/)
#  * So you write `ssh instance_name` instead of `ssh -i ~/.ssh/gate.pem ec2-user@ec2-12-345-67-89.us-east-1.compute.amazonaws.com`
#  * Autocompletion!
#  * Command history is clean and reusable for `ssh` and `scp`
#  * Instance IP change on reboot is not problem anymore
#  * Works well with [sssh2](https://github.com/dmi3/bin/blob/master/sssh2).

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Instalation
#  -----------
#  * Setup [aws-cli](https://github.com/aws/aws-cli#aws-cli)
#  * (Optional) Install [latest Openssh in 16.04](https://gist.github.com/stefansundin/0fd6e9de172041817d0b8a75f1ede677)
#  * Change credentials in `TEMPLATE` ↓

#  Usage
#  -----
#  * If you have Openssh > 7.3:
#    - `ec2ssh.sh | tee ~/.ssh/aws_config`
#    - Add [Include aws_config](https://superuser.com/a/1142813) to `~/.ssh/config`
#  * Else (will overwrite file)
#    - ec2ssh.sh | tee ~/.ssh/config

TEMPLATE="
Host \$1
  HostName \$0
  User ubuntu
  IdentityFile ~/.ssh/gate.pem
  IdentitiesOnly yes"

aws ec2 describe-instances \
 --filter "Name=tag-key,Values=Name" "Name=tag-value,Values=*" "Name=instance-state-name,Values=running" \
 --query "Reservations[*].Instances[*][NetworkInterfaces[0].Association.PublicDnsName,Tags[?Key=='Name'].Value[] | [0]]" \
 --output text | xargs -L 1 bash -c "echo -e \"$TEMPLATE\""