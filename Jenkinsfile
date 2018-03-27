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
        sh script: 'ls -l . asm/'
      }
    }
    stage('Build') {
      agent {
        dockerfile true
      }
      steps {
        sh script: 'make'
        sh script: 'make pdf'
        sh script: 'ls -l . asm/'
      }
    }
    stage('Archive') {
      steps {
        archiveArtifacts 'asm/*.asm'
        archiveArtifacts 'Meltdown-Spectre.pdf'
      }
    }
    stage('Update Repository') {
      when {
        environment name: 'CHANGE_FORK', value: ''
        expression { GIT_URL ==~ 'https://github.com/osdevelopment-info/.*' }
        expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
      }
      steps {
        sshagent(['6452f2aa-2b69-4fa7-be5f-5f0ef6d3acba']) {
          sh """
            ls -l . asm/
            git clone --no-checkout \$(echo ${GIT_URL} | sed 's/https:\\/\\//git@/' | sed 's/\\//:/') checkout
            git config --add user.email ci@sw4j.org
            git config --add user.name "CI Jenkins"
            git config push.default simple
            cd checkout
            git checkout ${GIT_BRANCH}
            ls -l .. ../asm/
            cp ../*.pdf .
            cp ../asm/*.asm asm/
            ls -l . asm/
            git diff --quiet && git diff --staged --quiet || git commit -am 'Update program code and documentation'
            git push
            cd ..
            rm -rf checkout
          """
        }
      }
    }
  }
}
