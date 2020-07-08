#!/bin/bash

sudo apt instal awscli

aws configure

# run keygen script here with different name assosiated. i.e. "AWS_Remote"
    # create key and save name and public key in glabal variables
ssh-keygen -f /home/ubuntu/.ssh/AWS-Remote -N ""

${pem-keyname} = "AWS-Remote"

${pem-keypub} = "cat /home/ubuntu/.ssh/AWS-Remote.pub"

# install terraform via installterraform.sh script
sh installterraform.sh

# run terraform from the set-up folder to build the network and manager node. i.e. "cd start-up/ && terraform apply -var 'pem_keyname=${pem_keyname}' -var 'pem_keypub=${pem_keypub}'"
# user is asked for "username" and "password" for Database