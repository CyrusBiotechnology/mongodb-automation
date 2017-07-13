node {
  def GIT_SHA = git.getCommit()
  def CONTAINER_ID

  stage('Checkout') {
    checkout scm
    sh 'git submodule update --init --recursive'
  }

  stage('Build'){
    CONTAINER_ID = sh(returnStdout: true, script: 'docker build --pull . | awk "END {print \\$3}"')
  }


  stage('Push Container') {
    build job: 'push-container', parameters: [
      [$class: 'StringParameterValue', name: 'LOCAL_CONTAINER', value: CONTAINER_ID],
      [$class: 'StringParameterValue', name: 'REMOTE_CONTAINER', value: 'mongo-automation'],
      [$class: 'StringParameterValue', name: 'GIT_BRANCH', value: env.BRANCH_NAME],
      [$class: 'StringParameterValue', name: 'GIT_COMMIT', value: GIT_SHA]
    ]
  }

}
