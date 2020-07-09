# QAC Final Project
Final group project following the QAC Final Project Brief (DevOps) due 10th July 2020.

## Index
1. [Brief](#brief)
    - [Project Proposal](#pp)
2. [MoSCoW](#moscow)
3. [Trello Board](#trello)
    - [Initial Board](#ib)
    - [On-going Changes](#ogc)
    - [Final Board](#fb)
4. [Risk Assessment](#ra)
    - [Risk Assessment Analysis](#raa)
5. [Project Architecture](#projectarc)
    - [Final Application Infrastructure](#fpi)
    - [Deployment](#deployment)
    - [Toolchain & Workflow](#taw)
    - [Tools, Technologies & Languages Used](#technologies)
       - [MySQL](#mysql)
       - [Docker](#docker)
       - [Terraform](#terraform)
       - [Ansible](#ansible)
       - [Jenkins](#jenkins)
6. [Monitoring](#monitoring)
    - [CloudWatch](#cw)
    - [Alarms](#alarms)
7. [Issues](#issues)
8. [Billing](#billing)
9. [Security](#security)
    - [IAM](#iam)
    - [CloudTrail](#cloudtrail)
    - [Security Groups](#securityg)

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

![](images/initial_architecture.PNG)

The above image displays the initial architecture discussed during the first team stand-up. Note, this diagram is not the overall deployment, but the application infrastructure itself.

An EKS Cluster, consisting of a manager node and two worker nodes, sits inside a subnet, inside a VPC, within the AWS cloud. The Kube (Kubernetes) Manager encompasses a single pod in which three containers are housed: NGINX, front-end and back-end. 

Once the cluster is deployed, the replicas are load-balanced across the worker nodes. NGINX is configured so that vulnerable ports (4200, 9966) are not open to the public, especially those who intend to be malicious. Only port 80 is accessible to the open internet for that reason - this is achieved through an Internet Gateway that is attached to a Route Table associated with the EC2 instances.

## MoSCoW <a name="moscow"></a>
We set out the requirements for this project in order to plan and estimate our tasks in order to meet the MVP. Firstly we decided that we must have the front and back end of the application deployed, which was the first task we set about completing. In addition, it was also necessary to have a continuous integration/deployment workflow, so we discussed what tools and technologies we would use to fulfill this criteria and added them into our Trello planning. Next we decided that to ensure quality of the application and adhere to best practices, we should include testing of the app. Upon reading the backend documentation, we realised that there was already a database encoded with the app, however we thought it would be better to include an external database but we added this to our 'could have' criteria as it was not necessary to meet the MVP. Finally, the project only required us to deploy the application and we were instructed not to change any of the source code, so we added this to the 'won't have' criteria. 

## Trello Board <a name="trello"></a>
In terms of project tracking, we used a kanban-style Trello Board. Agile methodology was carried out where possible, in line with the project brief. Multiple sprints were conducted, as well as daily scrums. After our morning scrum, the group then divided into sub-groups to complete certain tasks. At the end of the day, the group help another meeting to see how the sub-groups got on with their tasks to coordinate workflow. What's more, a sprint retrospective was scheduled towards the end of project completion.


### Initial Board <a name="ib"></a>
![](images/initial_trello_board.PNG)

This was the Trello Board after our first scrum meeting. Initially, we debated which tools and technologies we should use and plotted initial tasks on the board. Then we made our collaborative GitHub, DockerHub and IAM user accounts. We were each assigned to tasks and then this was plotted on the different trello cards. The tasks on the board were colour coordinated to help us determine which tasks were related and quickly communicate information about the tasks. 

![](https://github.com/Jortuk/FinalProject/blob/readme/images/meetingoutline.png)

After meetings we would summarise the main points of the meetings and record any important issues or tasks that need to be completed. It was effective to record our activities in this way to effectively plan and manage our time and also gave us a history of events so we could evaluate our current progress and how much time it may take us to complete current or future tasks.

![](https://github.com/Jortuk/FinalProject/blob/readme/images/checklists.png)

Another feature of Trello we utilised was the checklist. This acted as a product backlog where we could view our tasks quantified and keep on track with what tasks need to be completed. Again it was useful to estimate how long future tasks might take us and also give us an indication of any areas that might be taking longer than expected. 

![](https://github.com/Jortuk/FinalProject/blob/readme/images/trelloissuetracking.png)

Underneath each card we utilised the comment feature to record any issues that we were facing. Here we could include possible suggestions that we had discussed in order to solve the issue in order to form a plan of action if the issue persisted. 


### On-going Changes <a name="ogc"></a>
![](images/ongoing_trello_board.PNG)

During project progression, several changes were made. This was a result of issues or a change of mind in terms of the technology used:
- Deciding to use Docker Swarm opposed to the originally planned EKS Cluster. This was due to an issue with passing the environment variables, required to access the database, to the back-end container
- NGINX was used to load-balance containers across nodes
- Multiple branches were created on the GitHub repository to enable sub-groups to work on independent features without interference
- Jenkins was used instead of AWS CodePipeline - this is because Jenkins is a CI/CD server we were all more familiar with 
- Security groups were configured to better manage permissions and traffic allocation
- An external RDS instance was created to act as a database for deployment

### Final Board <a name="fb"></a>
![](images/final_board.PNG)

After each of the checklists were completed, the labels on each of the cards was changed to completed and the cards were moved to the done section of the board. In the final stages of completing the project, we had just to complete the presentation, finalise the readme and record the youtube tutorials for deploying the app. We also plotted our future improvements and tasks that we did not get round to completing in the 'To Do' section of the board, as theoretically we would be completing these in the next sprint. 

## Risk Assessment <a name="ra"></a>

| Number |Date | Risk | Response Strategy | Outcome | Likelihood | Impact | Proximity |
| --- |---  | ---   | ------------------ | ------- | ---------| --------| ---------|
1 | 01/07/20 | Cost exceeds budget | Set up billing alerts and routinely check costs | The project is completed within budget with only necessary costs spent | Low | Low | Once AWS resources are used | 
2 | 01/07/20 | Project not completed on time | Use trello for project tracking and managing | Time is managed effectively and project is completed on time | Low | High | Immediate |
3 | 01/07/20 | Service failure | Implement testing in order to ensure services work as expected | All systems run as expected | Medium | High | Development Stage |
4 | 01/07/20 | COVID 19 | Adhere to government guidelines and distribute work between healthy team members | Project is completed on time and meets the MVP | Low | Medium | Immediate |
5 | 01/07/20 | General illness/absence | Work is distributed between healthy team members | Project is completed on time and meets the MVP | Low | Medium | Immediate |
6 | 02/07/20 | Diminished communication due to working remotely | Utilise trello and teams to plan tasks and hold frequent meetings | Project is completed on time and meets the MVP | Low | Medium | Immediate |
7 | 02/07/20 | Link failure | Use the terminal to monitor service responses | Links are working and delivering expected data | Low | Medium | Development stage |
8 | 02/07/20 | Secret data stolen | Use environment variables | Sensitive data is not exposed on github and only known within the development team | Low | High | Development stage |
9 | 02/07/20 | Developers knowledge not sufficient to complete the project | Review materials and research any unknown areas, contact other team members and post issues on Trello | Developers have complete understanding of the technologies used and this is reflected in all aspects of the project | Medium | High | Development stage |
10 | 02/07/20  | Man in the middle attack | Limit IP access to the machines, make use of VPCs, route tables and security groups | Only authorised access to the machines allowed | Low | High | Development Stage |

![](images/initialriskmatrix.png)

The matrix demonstrates that the majority of the risks are located in the yellow band. Overall, this shows a medium level of combined risk. This required measures to reduce the potential effects. Additionally, risks held within the red band required more levels of precaution and constant monitoring.

### Risk Assessment Analysis <a name="raa"></a>
| Number | Analysis | 
|--- | ---|
1 | We had been given a budget of £20 by the Academy to complete the project. We started off by using the smallest instances on the free tier however after running the app and other software we found we did not have enough memory or CPU. Therefore, we decided to increase the size of our instances which also increased our costs. We made use of the AWS billing dashboard which helped us track our costs. After decreasing the size of the images to alpine images we were able to keep the memory and CPU usage down which kept our costs at a reduced amount as well. Another option we explored was to only copy the necessary files into the docker container and run it using a java -jar command rather than maven spring boot, however we felt that we did not have enough time to utilise this strategy. |
2 | We utilised resources such as daily scrums, meetings and Trello to keep track of our progress and manage our time effectively. We spent a lot of time working with Kubernetes which towards the end of the sprint we decided to swap out for Docker Swarm as we were confident we could get that working and we were conscious of not meeting the deadline |
3 | After struggling to get Kubernetes to work, we decided to utilise Docker Swarm instead so that we could meet the MVP and deadline. We spent a lot of time trouble shooting and making notes of processes that were sucessful should we need to pass them on. |
4 | We conducted daily scrums in which we checked for any COVID related symptoms or worries. None of the team members were ill at any point |
5 | We conducted daily scrums in which we checked for any illness related symptoms and where team members could communicate any required absences. None of the team members had any illnesses or took any absences. |
6 | We conducted daily scrums and frequent meetings, utilising Teams screen share and instant messaging functionality to keep in contact throughout the project. We also used Trello to keep track of tasks. This was not an issue for us. |
7 | The frontend had trouble communicating with the backend so we had to use the IP address instead of the container name. |
8 | Our information was not exposed as we made use of environment variables. |
9 | We communicated well to help eachother solve any issues we were facing. We also spent a lot of time researching any areas we weren't familiar with and any areas we were stuck on until we came to a solution. |
10 | We made use of security measures to prevent any cyber attacks. |

## Project Architecture <a name="projectarc"></a>
### Final Application Infrastructure <a name="fpi"></a>
![](images/final_architecture.PNG)

The final application infrastructure isn't too dissimilar from the original. As you can see, security groups have been added. The other major change is that instead of using an EKS Cluster, Docker Swarm was used. This is because we had issues deploying the application with kubernetes as the environment variables required for accessing the database would not pass through to the back-end container. After trying several solutions, such as ConfigMaps and Secrets, the decision was made to use Docker Swarm.

### Deployment <a name="deployment"></a>
![](images/pipeline.PNG)

The above diagram demonstrates the deployment pipeline for the project. The cloud provider used was AWS from which we used resources such as EC2 instances, Subnets, a VPC and so on. Developing on this point, Terraform was used to provide Infrastructure as Code (IaC), which provisioned AWS resources, automatically creating them with a focus on the code being reusable. Furthermore, Jenkins would automatically build the application on the resources made from Terraform via a GitHub Webhook, before deploying it containers using Docker Swarm, loading balancing replicas defined in the docker-compose.yml across worker nodes.

Ansible was installed onto the manager node through Jenkins, then Ansible would install, initialise, and join the worker nodes to the manager with no extra configuration required. Finally, docker images were version controlled using Docker Hub. Scripts in the Jenkinsfile were designed to re-build and push the latest images to Docker Hub before being deployed in the swarm. 

### Toolchain & Workflow <a name="taw"></a>
![](images/toolchain_and_workflow.PNG)

This toolchain and workflow diagram closely reflects what would be used by DevOps engineers in real working environments. Our project includes all the required functionality, through tool integration and feeback, to be passed onto a operations team for continued development.

### Tools, Technologies & Languages Used <a name="technologies"></a>
* The Spring Pet Clinic application is a spring boot application we ran using maven 
* RDS MySQL database to persist data entered on the website 
* Ansible to provision VMs
* Jenkins to automate the building process
* DockerFiles to Dockerise the front and back end applications
* DockerHub to version control the images
* Docker Swarm to deploy the application
* Terraform to provision AWS resources
* Trello to track and manage the project
* Microsoft Teams to communicate throughout the project
* GitHub to version control the code
* A webhook to trigger automated builds from updates to the source code
* Scripts to carry out automated commands
* IAM users to provide access to the AWS resources
* CloudWatch to monitor AWS resource activity, including CloudWatch Metrics and Alarms
* CloudTrail to monitor IAM user activity
* SNS topic
* AWS billing alerts
* YAML files
* Linux
* Java
* CSS
* HTML

### MySQL <a name="mysql"></a>
A RDS MySQL database was set up on AWS in order to persist data from the website. This required the application-mysql.properties file to be modified so that the first three lines are uncommented and to include the endpoint for the database, username and password. In order to protect this sensitive information we entered the export command with the values for these varibles in the .bashrc and then used variable substitution in the file. 

### Docker <a name="docker"></a>
The front and back end applications are containerised using docker utilising apline images to reduce the memory usage. Initially it was intended to use kubernetes to deploy the application however after encountering issues we decided to use docker swarm instead. The front end application communicates with the back end through the instruction of the environment.ts, pulling the database information to display on the site and also enabling CRUD functionality. We utilised DockerHub's team repository functionality so that we could all have access from our personal accounts in order to push and retrieve images. This function is free for teams of up to 3 people and $9 a month for teams of any higher number. We decided to keep the cost down by enabling the only docker developers access to the repository. 

### Terraform <a name="terraform"></a>
Terraform was used to provision the AWS resources; EC2 instances including master and swarm worker nodes, an internet gateway, the RDS instance, route table, security groups, subnets and VPC.

### Ansible <a name="ansible"></a>
Ansible was used to provision the VMs with docker and set up the master and nodes as part of a swarm. 

### Jenkins <a name="jenkins"></a>
Jenkins was used to provision the manager node with docker and ansible, and deploy ansible to run the scripts.

## Monitoring <a name="monitoring"></a>
### CloudWatch <a name="cw"></a>
![](https://github.com/Jortuk/FinalProject/blob/readme/images/petclinicdashboard.png)
By creating a custom dashboard, we were able to track the PetClinic's resources. We configured a dashboard that displays the current statistic at the time of access. We decided to monitor the CPU usage and the available memory of the databases. These statistics helped us to troubleshoot when we were having issues running software on the VMs and informed our decision to upgrade the CPUs.

### Alarms <a name="alarms"></a>
![](https://github.com/Jortuk/FinalProject/blob/readme/images/alarms.png)
We set up alarms to trigger when CPU usage went above 80. We also set up an alarm to notify the team when the memory availability of the databases was running low, as we thought this would be useful should the website be deployed in production. 

## Issues <a name="issues"></a>
* Database not initialising. To solve this we had to add a line of code into the application-mysql.properties file which explicitly called for the data to be initialised upon start up. This sucessfully executed the scripts in the file which populates the database with tables and inputs some initial information.
* Dependencies not installing when creating Docker images. A few of the dependencies were not compatible with the OS system we were using so these needed to be altered in order for the Docker build to be successful. 
* VMs crashing when using Kubernetes. After monitoring the VM CPU uand RAM usage, we decided to upgrade the instances. After still having problems with this we decided to use EKS.
* EKS turning on instances after we turned them off. The cluster needed to be stopped at the end of the working day to prevent unecessary increases in billing. Individual resources would be automatically redeployed if the cluster was still running.
* EKS not deleting. Each individual resource needed to be deleted manually in sequential order before the cluster could be deleted. This was improved when terraform was incorporated and terraform destroy could be executed to delete the EKS.
* Environment variables not exporting into EKS containers. After using techniques such as ConfigMaps, environment variables and secrets to no avail we decided to migrate onto Docker Swarm.
* Ansible unable to SSH into workers. Config files in the wrong location.

## Billing <a name="billing"></a>
| Date | Spend ($) | Resources |
| --- | ---:| --- |
01/07/20 | 0.5 | 2 t2.micro instances and RDS |
02/07/20 | 0.13 | 2 t2.micro instances and RDS | 
03/07/20 | 0.50 | 4 t2.micro, RDS and t2.small |
04/07/20 | 1.34 | 4 t2.micro, RDS and t2.small |
05/07/20 | 1.79 | 1 t2.micro, RDS, 2 t2.small and 1 t2.medium |
06/07/20 | 3.89 | 2 t2.micro, RDS, 2 t2.small and 2 t2.medium, EKS |
07/07/20 | 5.68 | 2 t2.micro, RDS, 2 t2.small and 2 t2.medium, EKS |
08/07/20 | 8.48 |  2 t2.micro, RDS and 2 t2.medium |
09/07/20 | 9.91 | 2 t2.medium, 2 t2.micro, 2 t2.small RDS |

For this project we had a budget of £20. Initially we tried to stay within the free tier usage that AWS offers, however the apps required a higher memory and CPU usage than what the free tier instances offered. We gradually increased the size of the instances which in turn incurred a higher cost. In addition, the EKS also increased the charges, after not being sucessful with Kubernetes we decided not to use this service. In order to track our spends, we set up a billing alert to notify the account owner's email when 80% of the budget was reached.

## Security <a name="security"></a>
### IAM <a name="iam"></a>
We set up IAM users and gave specific permission policies to the developers depending on their roles in the project. The IAM users had password policies, multi-factor authentication and security credentials in order to keep accounts secure.

### CloudTrail <a name="cloudtrail"></a>
Cloud trail provided a history of each users activity on the AWS resources so it was easy to keep track of activity on the account. We opted out of creating a cloud trail as this could have incurred extra cost and the team had good communication throughout the project.

### Security Groups <a name="securityg"></a>
In addition to the previous security measures, a security group with specific rules were put in place. A security group, used for all machines, have rules for the following ports: 22, 80, 4200, 9966. Port 22, enabling a machine to be 'SSHed' into, was only accessible via each members IP addresses. Port 4200, used for the front-end, was available via the IP addresses of the machines in the Swarm, closed off to the open internet. Port 9966, the back-end, was again only reachable by the IP addresses of each member. And finally, port 80, used for NGINX, was open to the entire internet. NGINX was configured so that the port for the front-end (4200) was upstreamed and port-forwared to port 80.

# Individual Showcases
## Jordan and Sophie
We were delegated the task of containerising and running the backend application. We also initialised the database and connected it to the backend application. After testing to see that the database was being populated by the test data and the scripts were successfully executing, we built the DockerFile in order to build the image. After the front and backend images were complete, they were pushed to DockerHub to a shared repository in order to be incorporated with the Kubernetes Cluster. We also had intended to deploy the application using Kubernetes. After successfully setting up the system on EKS, we were struggling to export the variables across into the containers and the time and cost of the EKS service was considerably larger than running the Docker containers in the testing environment. Thus, we decided to deploy the application using Docker Swarm instead. After creating a custom NGINX image to proxy onto the frontend container port, we were able to create a compose yaml to deploy the services as a stack. The application successfully deployed using docker swarm and the front and backend applications were able to communicate.

## Emmanuel
Aside from Jenkins, some other options available would have been CircleCI and Red Hat however we chose Jenkins not just because it is largely encouraged at QA but because Jenkins is much leaner at allowing for automating processes when adding new code all the way through to acceptance testing. 

This continuous delivery tool allows for a high level of automation. Running Jenkins allowed me to continuously check that the code compiles. The only few disadvantages of Jenkins is its initial setup. For the project, I constructed a Jenkinsfile which details exactly which directory Jenkins can go to execute every code required and build the necessary environment in order to allow the code to run as required. Jenkins was used to provision the manager node with docker and ansible, and deploy ansible to run the scripts. It was an extremely integral part of enabling our pipeline to successfully run and deploy our application.

The process of using Jenkins for the project pipeline and deployment was not always straight forward, as one of the problems I kept encountering was having Jenkins recognise the IP of the localhost defined within the etc/hosts. Another issue was the fact that, the type of instance we used in order to run Jenkins was not always suitable. We first began on t2.small AWS instance which was far too small to run our application in its size, furthermore, the smaller the size of the instance the longer it took for certain sections of the stages in the Jenkins pipeline to complete successfully. 
For example, when running on a t2.medium instance, the "Testing environment" stage took 21 minutes to complete and the "Deploying" stage would take another 11 minutes to deploy. Overall, it was often taking over 30 minutes to complete the pipeline and run the application. This would not have been a problem if the pipeline build was always successful, however often halfway through a certain stage, it would fail hence adding to the time it took to troubleshoot and successfully complete the Jenkins stage of our project. I was able to solve this issue by upgrading the instance to t2.large which allowed Jenkins to run much more smoothly and quickly, reducing the pipeline time to under 2 minutes.

## Junaid and Emmanuel

Emmanuel and I were tasked with containerising and running the frontend of the application. This involved the installation of JavaScript runtime environment node.js and the web-application framework angular in order to run the java application successfully. We had a few difficulties initially with installing dependencies due to what seemed to be out-of-date dependencies defined in the package.json file, where the dependencies were listed. As a result, working versions of angular and other dependencies were found and installed which helped resolve the issues that we faced during initial installation of the frontend application. Once we were able to run the application on the internet, we moved onto dockerizing the frontend application by creating a Dockerfile. There were brief issues with the website not showing when attempting to run the application with docker commands. This issue was resolved by mapping the port in the docker command by using the “-p” flag in the “docker run” command. Once this issue was resolved the frontend application was ready for communication with the backend, which was taken care of by Sophie and Jordan.

# Testing
## Unit Testing 
We tested the backend of the application which includes 172 tests, using maven. The script to run the tests is below:

* #!/bin/bash
* cd spring-petclinic-rest
* sudo apt install maven -y
* mvn test

All of the tests were successful and the code was included in the Jenkins pipeline to run the tests automatically.

![](https://github.com/Jortuk/FinalProject/blob/readme/images/test_backend.PNG)

## Front End Testing
Unfortunately after several attempts at automating the frontend testing via Jenkins it was found that doing so was not achievable in the given time frame for the project. In order to do so, Selenium scripts were required but this process would have required a large amount of learning towards the end of the project. This should be considered for future improvements. 

## Future Improvements <a name="fi"></a>
### Further Testing <a name="ftesting"></a>
If we had had a longer time period to complete the project testing is a key area that we would like to strengthen. Stress testing would be useful to ensure that the application could handle the increased traffic and requests that would occur during a production environment. Unit testing would also provide us a better and in depth indication of the way in which components of the app and code is able to run sucessfully. In addition, we would conduct testing on the database to ensure that the data is stored, retrieved, updated and deleted correctly in accordance with requests from the website.

### Enhanced Monitoring <a name="enhanced"></a>
It would be useful to have a CloudWatch event trigger a lambda function that can manage the EC2 instances, making sure old ones are turned off after a new instance is built through the pipeline. More complex CloudWatch monitoring would have given us access to the instances RAM usage, which we found to be too small when running the applications. To monitor this we used htop, however CloudWatch would've given us easier access to the statistics by including them in our custom dashboard. In addition, XRAY is also a useful feature that would've given us information on how our application was responding to HTTP requests. However we did not have enough time to implement this.

### Implementing EKS <a name="eks"></a>
Rather than deploying the application through Docker Swarm, deploying the application with EKS would be a more robust and easily manageable solution. Initially this is what we intended for the project, however using EKS consumed a larger amount of our budget and time, as constructing and destructing the service was complicated and lengthy due to having to delete dependencies before having permission to take the stack and cluster down. In addition, we also struggled with getting the environment variables across to the container which we decided was hindering our progress with the project as a whole. We concluded that Docker Swarm would be a better solution to meet the MVP by the deadline, however if we had more time and a higher budget we would like to include EKS in the deployment of the app.
