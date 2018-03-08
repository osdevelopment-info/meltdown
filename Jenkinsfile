pipeline {
  agent {
    dockerfile true
  }
  stages {
    stage('Checkout') {
      steps {
        // checkout scm
        sh script: """
          git fetch
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
