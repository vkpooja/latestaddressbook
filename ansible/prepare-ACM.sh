#! /usr/bin/env bash
pip3 install ansible
pip3 install boto3
mkdir /home/ec2-user/.aws 
cp .aws-credentials /home/ec2-user/.aws/credentials
/home/ec2-user/.local/bin/ansible-inventory -i /home/ec2-user/ansible/inventory_aws_ec2.yml --list