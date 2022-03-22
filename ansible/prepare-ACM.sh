#! /usr/bin/env bash
pip3 install ansible
pip3 install boto3
set AWS_ACCESS_KEY_ID=$1
set AWS_SECRET_ACCESS_KEY=$2
/home/ec2-user/.local/bin/ansible-inventory -i /home/ec2-user/ansible/inventory_aws_ec2.yml --list