def dockerRun = "docker run -d -p 8080:8080 rosliko/docker-app:${BUILD_NUMBER}"

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Rosliko/lesson8']])
            }
        }
        stage('Build_App') {
            steps {
                sh 'mvn clean install && mvn clean package'
            }
        }
        stage('Build_Image') {
            steps {
                sh "docker build -t rosliko/docker-app:${BUILD_NUMBER} ."
            }
        }
        stage('Push_Image') {
            steps {
                withCredentials([string(credentialsId: 'DockerHubPswd', variable: 'DockerHubPswd')]) {
                    sh 'echo "$DockerHubPswd" | docker login -u rosliko --password-stdin'
                }
                sh "docker push rosliko/docker-app:${BUILD_NUMBER}"
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['jenkins']) {
                    sh "ssh -o StrictHostKeyChecking=no jenkins@192.168.0.112 ${dockerRun}"
                }
            }
        }
    }
}
