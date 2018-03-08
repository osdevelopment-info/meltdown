pipeline {
  agent {
    dockerfile true
  }
  stages {
    stage('Checkout') {
      steps {
        checkout([
          $class: 'GitSCM',
          branches: scm.branches,
          extensions: scm.extensions + [[$class: 'WipeWorkspace']],
          userRemoteConfigs: scm.userRemoteConfigs
        ])
        // sh script: """
        //   git checkout ${BRANCH_NAME}
        // """
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
