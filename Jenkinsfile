node {
    checkout scm
    environment {
		AWS_ID = credentials("AWS_ID")
		AWS_ACCESS_KEY_ID = "${env.AWS_ID_USR}"
		AWS_SECRET_ACCESS_KEY = "${env.AWS_ID_PSW}"
	}

	  docker.image('postgres').withRun('-e "POSTGRES_PASSWORD=postgres"') { c ->
		  def ciEnv = docker.build 'ci-environment'  
		  ciEnv.inside("--link ${c.id}:db") {
					sh '''#!/bin/bash
						ls -lha
						java -version
						gradle -v
						node -v
						npm -v
						export PGPASSWORD=postgres && psql -h 127.0.0.1 -U postgres -c "SELECT 'success';"           
					'''
		  }
	  }
}
