pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="AWS_ACCOUNT_ID"
        REPO_NAME="sandbox-web"
        AWS_REGION="ap-south-1"
        IMAGE_TAG="v1.0.1"
        REPO_URI="922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web"
    }

    stages {
        stage('Logging into AWS ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                }
            }
       }
        stage('Clonning Repo') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kunalrbodke/jenkins-public.git']])
            }
       }
        stage('Building Image') {
            steps {
                script {
                    dockerImage = docker.build "${REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
        stage('Deploying to ECR') {
            steps {
                script {
                    sh "docker tag ${REPO_NAME}:${IMAGE_TAG} ${REPO_URI}:${IMAGE_TAG}"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
}
