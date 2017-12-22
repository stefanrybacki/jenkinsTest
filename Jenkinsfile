node {
    checkout scm
    environment {
		AWS_ID = credentials("AWS_ID")
		AWS_ACCESS_KEY_ID = "${env.AWS_ID_USR}"
		AWS_SECRET_ACCESS_KEY = "${env.AWS_ID_PSW}"
	}

	  docker.image('postgres').withRun('-e "POSTGRES_PASSWORD=postgres" -p 3306:3306') { c ->
		  def ciEnv = docker.build 'ci-environment'  
		  ciEnv.inside("--link ${c.id}:postgres") {
					sh '''#!/bin/bash
						ls -lha
						java -version
						gradle -v
						node -v
						npm -v
						export PGPASSWORD=postgres && psql -h postgres -U postgres -c "SELECT 'success';"           
					'''
		  }
	  }
}
