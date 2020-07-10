#!/bin/bash
sudo docker system prune
sudo docker rmi $(docker images -aq)
sudo docker build -t t2fp/frontend:final ./spring-petclinic-angular
sudo docker build -t t2fp/backend:new .


sudo docker push t2fp/frontend:final
sudo docker push t2fp/backend:new


#curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/kubectl
#chmod +x ./kubectl
#mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
#echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
#kubectl version --short --client
source ~/.bashrc
#aws eks update-kubeconfig --name example

#kubectl create -f /var/lib/jenkins/workspace/pet_clinic/K8s/backend.yml
#sleep 5
#kubectl create -f /var/lib/jenkins/workspace/pet_clinic/K8s/frontend.yml
#sleep 20
#kubectl create -f /var/lib/jenkins/workspace/pet_clinic/K8s/nginx.yml
#kubectl create -f ./K8s
#kubectl create -f ./K8s/t2fp-deployment.yml


sudo env USERNAME="${USERNAME}" env PASSWORD="${PASSWORD}" env URL="${URL}" docker stack deploy -c docker-compose.yml t2fp