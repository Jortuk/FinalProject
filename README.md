# QAC Final Project
Final group project following the QAC Final Project Brief (DevOps) due 10th July 2020.

## Index
1. [Brief](#brief)
    - [Project Proposal](#pp)
2. [Trello Board](#trello)

## Brief <a name="brief"></a>
As specified in the project brief, the following applications are to be deployed:
- A front-end version of the PetClinic WebApp coded in angular js (<a href="https://github.com/spring-petclinic/spring-petclinic-angular">Link</a>)
- A back-end, restful API version of the PetClinic WebApp coded in java (<a href="https://github.com/spring-petclinic/spring-petclinic-rest">Link</a>)

Workflows, both deployment and development, must be automated with the following considerations in mind:
- Which tools and technologies, covered over the training period, will be used
- Multiple environments to facilitate testing
- Automated building and continuous deployment based on VCS modifications
- A record of total costs incurred

### Project Proposal <a name="pp"></a>
Our proposal focused on fulfilling the project brief by using the following architecture:
- Infrastructure as Code (IaC) deployed with Terraform
- Configuration Management using Ansible
- Utilising AWS CodePipeline, acting as a CI/CD server via a webhook to this repository
- An AWS EKS Cluster that will run the app
- Monitoring the project by using AWS services such as CloudWatch, CloudTrail and X-Ray

<b>AN INITIAL ARCHITECTURE DIAGRAM NEEDS TO BE CREATED HERE</b>

## Trello Board <a name="trello"></a>
In terms of project tracking, we used a kanban-style Trello Board. Agile methodology was carried out where possible, in line with the project brief. Multiple sprints were conducted, as well as daily scrums.

## Technologies <a name="technologies"></a>
* The Spring Pet Clinic application is a spring boot application we ran using maven. 
* RDS MySQL database to persist data entered on the website. 
* Ansible to provision VMs.
* Jenkins to automate the building process.
* Docker to containerise the application and docker swarm to deploy the application.
* Terraform to provision AWS resources.
* Trello to track and manage the project.

# Deployment

## CI Pipeline <a name="CI Pipeline"></a>

## MySQL <a name="mysql"></a>
A RDS MySQL database was set up on AWS in order to persist data from the website. This required the application-mysql.properties file to be modified so that the first three lines are uncommented and to include the endpoint for the database, username and password. In order to protect this sensitive information we entered the export command with the values for these varibles in the .bashrc and then used variable substitution in the file. 
### Issues
03/07/20 - The mysql scripts were not executing when the application was ran. Adding 'spring.datasource.initialization-mode=always' to application-mysql.properties resolved the issue. 

## Docker <a name="docker"></a>
The front and back end applications are containerised using docker utilising apline images to reduce the memory usage. Initially it was intended to use kubernetes to deploy the application however after encountering issues we decided to use docker swarm instead. The front end application communicates with the back end through the instruction of the environment.ts, pulling the database information to display on the site and also enabling CRUD functionality. We utilised DockerHub's team repository functionality so that we could all have access from our personal accounts in order to push and retrieve images. This function is free for teams of up to 3 people and $9 a month for teams of any higher number. We decided to keep the cost down by enabling the only docker developers access to the repository. 

## Terraform <a name="terraform"></a>
Terraform was used to provision the AWS resources; EC2 instances including master and swarm worker nodes, an internet gateway, the RDS instance, route table, security groups, subnets and VPC. 

## Ansible <a name="ansible"></a>
Ansible was used to provision the VMs with docker and set up the master and nodes as part of a swarm. 

## Jenkins <a name="jenkins"></a>
Jenkins was used to provision the manager node with docker and ansible, and deploy ansible to run the scripts.

# Billing 

# Risk Tracking
## Initial Risk Assessment

