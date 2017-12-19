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
    node {
	docker.image('postgres').withRun('-e POSTGRES_PASSWORD=postgres') { c ->
      
           /* set user etc */
        }
    }
      steps {
        sh '''
		export PGPASSWORD=postgres && psql -h 127.0.0.1 -U ci -d lvmstest -c "SELECT 'success';"
	'''
      }
    }

  }    
}
