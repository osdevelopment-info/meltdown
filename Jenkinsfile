pipeline {
  agent {
    dockerfile true
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
        sh script: 'git checkout ${BRANCH_NAME}'
      }
    }
    stage('Build') {
      steps {
        sh script: 'make'
      }
    }
    stage('Pdf') {
      steps {
        sh script: 'make pdf'
      }
    }
    stage('Archive') {
      steps {
        archiveArtifacts 'Meltdown-Spectre.pdf'
      }
    }
  }
}
