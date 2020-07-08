pipeline {
    agent any
    stages {
        stage('installation of environment'){
            
            steps{
                sh 'chmod +x ./script/*'
                sh 'bash ./script/before_installation.sh'
                sh 'bash ./script/ansible.sh'
            }
        }
        
        stage('Deploying'){
            
            steps{
                
                sh './script/docker.sh'
            }
        }
    }

}