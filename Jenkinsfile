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
          git pull
        """
      }
    }
    stage('Build') {
      agent {
        dockerfile true
      }
      steps {
        sh script: 'git checkout ${BRANCH_NAME}'
        sh script: 'make'
        sh script: 'make pdf'
        withCredentials([string(credentialsId: "2c643c15-f92b-4d22-bc95-6640fa74c163", variable: 'GH_TOKEN')]) {
          sh """
            git config --add user.email ci@sw4j.org
            git config --add user.name "CI Jenkins"
            git config push.default simple
            # git diff --quiet && git diff --staged --quiet || git commit -a -m 'Automatic created documentation'
            # git push -fq https://${GH_TOKEN}@github.com/uweplonus/meltdown.git
          """
        }
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
