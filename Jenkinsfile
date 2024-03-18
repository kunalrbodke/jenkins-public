pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="922710632928"
        IMAGE_REPO_NAME="sandbox-web"
        AWS_DEFAULT_REGION="ap-south-1"
        IMAGE_TAG="v1.0.4"
        REPOSITORY_URI="922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web"
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
         stage('Clonning repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }
        stage('Building Image') { 
            steps { 
                script{
                    dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
        stage('Deploying to ECR') {
            steps {
                sh 'echo "${IMAGE_REPO_NAME}:${IMAGE_TAG}"'
                // script{
                //     docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {

                //     // dockerImage.push ("${IMAGE_REPO_NAME}:${IMAGE_TAG}")
                //     // dockerImage.push("IMAGE_TAG")
                //     }
                // }
            }
        }
    }
}
