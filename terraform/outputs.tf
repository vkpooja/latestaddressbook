output "subnet-id"{
    value=module.my-subnet.subnet.id
}
output "ec2-ip"{
    value=module.my-webserver.ec2-ip.public_ip
}