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