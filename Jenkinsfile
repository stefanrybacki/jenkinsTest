pipeline {
  environment {
    AWS_ID = credentials("AWS_ID")
    AWS_ACCESS_KEY_ID = "${env.AWS_ID_USR}"
    AWS_SECRET_ACCESS_KEY = "${env.AWS_ID_PSW}"
  }
  
  agent {
    dockerfile {
      dir '.'
      additionalBuildArgs '--force-rm'
    }
  }

  stages {
    stage('Describe Environment') {
      steps {
        sh 'echo ${AWS_SECRET_ACCES_KEY} > ~/test.txt && cat ~/test.txt'
      }
    }
  }    
}
