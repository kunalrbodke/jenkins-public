pipeline {
    agent none
    environment {
        IMAGE_TAG="v01.0.8"
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
                script{
                    checkout scm
                    
                    dockerImage = docker.build("${REPOSITORY_URI}:${IMAGE_TAG}-amd64")

                    docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {

                    dockerImage.push()

                    sh 'docker rmi -f $(docker images -a -q)'
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

                    sh 'docker rmi -f $(docker images -a -q)'
                    }
                }
            }
        }

// Docker Manifest        
        stage('Bringing Docker Manifest') {
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
