#! /usr/bin/env bash
pip3 install ansible
pip3 install boto3
aws configure set aws_access_key_id $1
aws configure set aws_secret_access_key $2
/home/ec2-user/.local/bin/ansible-inventory -i /home/ec2-user/ansible/inventory_aws_ec2.yml --graph
DOCKER_IMAGE=$3 /home/ec2-user/.local/bin/ansible-playbook -i /home/ec2-user/ansible/inventory_aws_ec2.yml docker-deploy.yml