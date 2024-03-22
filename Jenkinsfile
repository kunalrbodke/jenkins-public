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
// // amd64
//         stage('Running on Master Node for AMD64 arch.') {
//             agent {
//                 node {
//                     label 'Master'
//                 }
//             }
//             steps {
//                 script{
//                     checkout scm
//                 }
//             }
//         }
//         stage('Building AMD64 arch Image') {
//             steps {
//                 script{
//                     dockerImage = docker.build("${REPOSITORY_URI}:${IMAGE_TAG}-amd64")
//                 }
//             }
//         }
//         stage('Deploying AMD64 arch Image to ECR') {
//             steps {
//                 script {
//                     docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {

//                     dockerImage.push()
//                     }
//                 }
//             }
//         }
// arm64
        stage('Running on Node01 for ARM64 arch.') {
            agent {
                node {
                    label 'Node01'
                }
            }
            steps {
                sh 'docker images'
                script{
                    checkout scm
                }
            }
        }
        stage('Building ARM64 arch Image') {
            steps {
                script{
                    dockerImage = docker.build("${REPOSITORY_URI}:${IMAGE_TAG}-arm64")
                }
            }
        }
        stage('Deploying ARM64 arch Image to ECR') {
            steps {
                script {
                    docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {

                    dockerImage.push()
                    }
                }
            }
        }
// // Docker Manifest        
//         stage('Bringing Docker Manifest') {
//             steps {
//                 script {
//                     docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {
//                         sh 'docker manifest create ${REPOSITORY_URI} ${REPOSITORY_URI}:${IMAGE_TAG}-amd64 ${REPOSITORY_URI}:${IMAGE_TAG}-arm64'
//                         sh 'docker manifest push ${REPOSITORY_URI}'
//                     }
//                 }
//             }
//         }
    }
}
