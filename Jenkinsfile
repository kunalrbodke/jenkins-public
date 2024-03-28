pipeline {
    agent none
    environment {
        IMAGE_TAG="v01.0.6"
        REPOSITORY_URI="922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web"
    }

    options {
        skipStagesAfterUnstable()
    }

    stages {
// amd64
        stage('Building & Pushing AMD64-arch Image') {
            agent {
                node {
                    label 'Master'
                }
            }
            steps {
                sh 'docker --version'
                sh 'docker buildx version'
                script{
                    checkout scm
                    
                    dockerImage = docker.build("${REPOSITORY_URI}:${IMAGE_TAG}-amd64")

                    docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {

                    dockerImage.push()

                    }
                }
            }
        }

// arm64
        stage('Building & Pushing Arm64-arch Image.') {
            agent {
                node {
                    label 'Node01'
                }
            }
            steps {
                script{
                    checkout scm

                    dockerImage = docker.build("${REPOSITORY_URI}:${IMAGE_TAG}-arm64")

                    docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {

                    dockerImage.push()
                    }
                }
            }
        }

// Docker Manifest        
        stage('Bringing Docker Manifest') {
            steps {
                script {
                    docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {
                        sh 'docker manifest create ${REPOSITORY_URI}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}-amd64 ${REPOSITORY_URI}:${IMAGE_TAG}-arm64'
                        sh 'docker manifest push ${REPOSITORY_URI}:${IMAGE_TAG}'
                    }
                }
            }
        }

// Clean Docker Images
        stage('Cleaning Docker Images in Controller') {
            agent {
                node {
                    label 'Master'
                }
            }
            steps {
                sh 'docker rmi -f ${REPOSITORY_URI}:${IMAGE_TAG}-amd64'
            }
        }
        stage('Cleaning Docker Images in Agent') {
            agent {
                node {
                    label 'Node01'
                }
            }
            steps {
                sh 'docker rmi -f ${REPOSITORY_URI}:${IMAGE_TAG}-arm64'
            }
        }
    }
}
