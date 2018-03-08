pipeline {
  agent {
    dockerfile true
  }
  stages {
  	stage('Clean') {
      steps {
        deleteDir()
      }
    }
    stage('Checkout') {
      steps {
        checkout scm
        sh """
          git checkout ${BRANCH_NAME}
        """
      }
    }
    stage('Build') {
      steps {
        sh script: 'make'
      }
    }
    stage('Pdf') {
      steps {
      	sh script: 'rm Meltdown-Spectre.pdf'
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
