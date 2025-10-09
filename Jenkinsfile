def dockerRun = "docker run -d -p 8080:8080 ambarodzich/docker-app:'${BUILD_NUMBER}'"

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/AMBarodzich/lesson8']])
            }
        }
        stage('Build_App') {
            steps {
                sh 'mvn clean install && mvn clean package'
            }
        }
        stage('Build_Image') {
            steps {
                sh 'docker build -t ambarodzich/docker-app:"${BUILD_NUMBER}" .'
            }
        }
        stage('Push_Image') {
            steps {
                withCredentials([string(credentialsId: 'DockerHubPwd', variable: 'DockerHubPwd')]) {
                    sh "docker login -u ambarodzich -p ${DockerHubPwd}"
                }
                sh 'docker push ambarodzich/docker-app:"${BUILD_NUMBER}"'
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['6cb2e3ae-a59f-4c0e-870d-528ebd8bc6d7']) {
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@13.220.117.124 ${dockerRun}"
                }
            }
        }
    }
}
