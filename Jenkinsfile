pipeline {
  agent any
  stages {
    stage('Cleanup') {
      steps {
        deleteDir()
      }
    }
    stage('Checkout') {
      steps {
        checkout scm
        sh script: """
          git checkout ${BRANCH_NAME}
        """
      }
    }
    stage('Build') {
      agent {
        dockerfile true
      }
      steps {
        sh script: 'make'
        sh script: 'make pdf'
      }
    }
    stage('Archive') {
      steps {
        archiveArtifacts 'asm/*.asm'
        archiveArtifacts 'Meltdown-Spectre.pdf'
      }
    }
  }
}
