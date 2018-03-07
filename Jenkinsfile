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
                sh script: 'make -v'
                sh script: 'nasm -v'
                sh script: 'ld -v'
            }
        }
        stage('Pdf') {
            steps {
                sh script: 'xelatex -v'
            }
        }
    }
}
