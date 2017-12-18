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
        sh '''
            env
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
