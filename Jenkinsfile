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
        stage {
            steps {
                sh 'docker images'
            }
        }
        stage('Clonning repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }
    }
}
