#!/bin/bash
sudo apt update -y
sudo apt-get install python3-pip -y
sudo apt install docker-compose -y
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
sudo apt update