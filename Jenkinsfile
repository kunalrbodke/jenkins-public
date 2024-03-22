pipeline {
    agent {
        node {
            label 'Node01'
        }
    }
    stages {
        stage('Hello') {
            steps {
                sh 'docker images'
            }
        }
    }
}
