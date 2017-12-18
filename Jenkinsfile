pipeline {
  environment {
    AWS_ID = credentials("AWS_ID")
    AWS_ACCESS_KEY_ID = "${env.AWS_ID_USR}"
    AWS_SECRET_ACCESS_KEY = "${env.AWS_ID_PSW}"
    GIT_BRANCH = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
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
        sh '''
            echo $GIT_BRANCH
            chmod +x awsInit.sh && ./awsInit.sh
	'''
      }
    }

    stage('Not dev branch') {
      when{
          expression { $GIT_BRANCH.contains('dev') }
      }
      steps {
        sh '''
           echo condition met
	'''     
      }
    }
  }    
}
