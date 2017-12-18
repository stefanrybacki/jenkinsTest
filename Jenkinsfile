pipeline {
  environment {
    AWS_ID = credentials("AWS_ID")
    AWS_ACCESS_KEY_ID = "${env.AWS_ID_USR}"
    AWS_SECRET_ACCESS_KEY = "${env.AWS_ID_PSW}"
  }
  
  agent {
    dockerfile {
      dir '.'
      additionalBuildArgs '--force-rm --build-arg AWS_SECRET_KEY=12345 AWS_ACCESS_KEY=12345'
    }
  }

  stages {
    stage('Describe Environment') {
      steps {
        sh '''#!/bin/bash
		env
		echo xyz: $AWS_SECRET_KEY
		echo zyx: ${env.AWS_SECRET_KEY}
		'''
      }
    }
  }    
}
