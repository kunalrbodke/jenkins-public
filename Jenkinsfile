pipeline {
    agent any
    environment {
        IMAGE_REPO_NAME="sandbox-web"
        IMAGE_TAG="v01.0.7"
        REPOSITORY_URI="922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web"
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        // amd64
        stage('Preparing Setup for AMD64 arch.') {
            agent {
                docker {
                    image 'local/ci-tools:latest-amd64'
                    reuseNode true
                }
            }
            steps {
                script{
                    checkout scm
                }
            }
        }
        stage('Building AMD64 arch Image') {
            steps {
                script{
                    do_build()
                    // dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}-amd64"
                }
            }
        }
        stage('Deploying AMD64 arch Image to ECR') {
            steps {
                script {
                    docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {

                    dockerImage.push ("${IMAGE_TAG}-amd64")
                    }
                }
            }
        }
    }
}
