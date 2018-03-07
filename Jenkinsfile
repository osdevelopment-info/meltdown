pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh script: 'make'
            }
        }
        stage('Pdf') {
            steps {
                sh script: 'xelatex -v'
            }
        }
    }
}
