pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        checkout scm
        git checkout master
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
    stage('Publish') {
      steps {
        withCredentials([string(credentialsId: "2c643c15-f92b-4d22-bc95-6640fa74c163", variable: 'GH_TOKEN')]) {
          sh """
            git config push.default simple
            git diff --quiet && git diff --staged --quiet || git commit -a -m 'Automatic created documentation'
            git push -fq https://${GH_TOKEN}@github.com/uweplonus/meltdown.git master:master
          """
        }
      }
    }
  }
}
