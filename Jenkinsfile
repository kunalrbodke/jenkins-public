def do_build()
{
  sh '''
  set -e
  echo "Build software for $arch"
  echo $WORKSPACE
  uname -a
  '''
}
pipeline {
    agent none
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
                    env.arch = "amd64"
                    // dockerImage = docker.build("${REPOSITORY_URI}:${IMAGE_TAG}-amd64")
                }
                do_build()
            }
        }
        stage('Deploying AMD64 arch Image to ECR') {
            steps {
                script {
                    docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {

                    dockerImage.push("${REPOSITORY_URI}:${IMAGE_TAG}-amd64")
                    }
                }
            }
        }
// arm64
        stage('Preparing Setup for ARM64 arch.') {
            agent {
                docker {
                    image 'local/ci-tools:latest-arm64'
                    reuseNode true
                }
            }
            steps {
                script{
                    checkout scm
                }
            }
        }
        stage('Building ARM64 arch Image') {
            steps {
                script{
                    env.arch = "arm64"
                    // dockerImage = docker.build("${REPOSITORY_URI}:${IMAGE_TAG}-arm64")
                }
                do_build()
            }
        }
        stage('Deploying ARM64 arch Image to ECR') {
            steps {
                script {
                    docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {

                    dockerImage.push("${REPOSITORY_URI}:${IMAGE_TAG}-arm64")
                    }
                }
            }
        }
        stage('Docker Manifest Layer') {
            agent any
            steps {
                script {
                    docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {
                        sh 'docker manifest create ${REPOSITORY_URI} ${REPOSITORY_URI}:${IMAGE_TAG}-amd64 ${REPOSITORY_URI}:${IMAGE_TAG}-arm64'
                        sh 'docker manifest push ${REPOSITORY_URI}'
                    }
                }
            }
        }
    }
}
