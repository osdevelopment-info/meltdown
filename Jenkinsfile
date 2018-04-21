pipeline {
  agent {
    node {
      label 'master'
    }
  }
  stages {
    stage('Cleanup') {
      steps {
        deleteDir()
      }
    }
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build asm and pdf') {
      agent {
        dockerfile {
          reuseNode true
        }
      }
      steps {
        sh script: 'make'
        sh script: 'make pdf'
      }
    }
    stage('Archive Artifacts') {
      steps {
        archiveArtifacts 'asm/*.asm'
        archiveArtifacts 'bin/*'
        archiveArtifacts 'Meltdown-Spectre.pdf'
      }
    }
    stage('Update gh-pages from master') {
      when {
        environment name: 'CHANGE_FORK', value: ''
        expression { GIT_URL ==~ 'https://github.com/osdevelopment-info/.*' }
        expression { GIT_BRANCH ==~ 'master' }
        expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
      }
      steps {
        sshagent(['6452f2aa-2b69-4fa7-be5f-5f0ef6d3acba']) {
          sh """
            git clone --no-checkout \$(echo ${GIT_URL} | sed 's/https:\\/\\//git@/' | sed 's/\\//:/') checkout
            git config --add user.email ci@sw4j.org
            git config --add user.name "CI Jenkins"
            git config push.default simple
            cd checkout
            git checkout gh-pages
            mkdir -p asm/
            cp ../*.pdf .
            cp ../asm/*.asm asm/
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
