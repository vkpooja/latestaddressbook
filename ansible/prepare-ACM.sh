#! /usr/bin/env bash
pip3 install ansible
pip3 install boto3
if [ -d "/home/ec2-user/.aws" ]
then 
else
  mkdir /home/ec2-user/.aws
  cp credentials /home/ec2-user/.aws/credentials
fi
/home/ec2-user/.local/bin/ansible-inventory -i /home/ec2-user/ansible/inventory_aws_ec2.yml --list