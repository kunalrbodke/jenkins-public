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
         stage('Clonning repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }
        stage('Initialize Builder') {
            steps {
                sh 'docker buildx create --use --name jenkins-builder'
                // sh 'docker buildx use jenkins-builder'
            }
        }
        stage('Creating Emulator for the Multi-Architecture') {
            steps {
                sh 'docker run --privileged --rm tonistiigi/binfmt --install arm64,arm'
            }
        }
        stage('Build Images for the Supported Architectures') {
            steps {
                script {
                    for (arch in ['arm64', 'amd64']) {
                        sh """
                        docker buildx build \\
                            --platform ${arch} \\
                            --output "type=docker,push=false,name=local/ci-tools:latest-${arch}" \\
                            .
                        """
                    }
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
                script{
                    docker.withRegistry('https://922710632928.dkr.ecr.ap-south-1.amazonaws.com/sandbox-web', 'ecr:ap-south-1:aws-ecr-access') {

                    dockerImage.push ("${env.IMAGE_TAG}")
                    }
                }
            }
        }
        stage('Clean Docker Images') {
            steps {
                sh 'docker image prune -a -f'
            }
        }
    }
}
