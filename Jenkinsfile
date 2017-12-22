node {
	environment {
		AWS_ID = credentials("AWS_ID")
		AWS_ACCESS_KEY_ID = "${env.AWS_ID_USR}"
		AWS_SECRET_ACCESS_KEY = "${env.AWS_ID_USR}"
	}
	
    checkout scm

	withEnv(["AWS_ACCESS_KEY_ID="+env.AWS_ID_USR,
	         "AWS_SECRET_ACCESS_KEY="+env.AWS_ID_USR]) {
	      stage('outside') {
			echo env.toString()
			echo AWS_ACCESS_KEY_ID
			echo AWS_SECRET_ACCESS_KEY
		  }
			 
		  docker.image('postgres').withRun('-e "POSTGRES_PASSWORD=postgres" -e "POSTGRES_USER=ci"') { c ->
				def ciEnv = docker.build 'ci-environment'  
				ciEnv.inside("--link ${c.id}:dbhost") {

				stage('Init') {
						sh '''#!/bin/bash
							java -version
							gradle -v
							node -v
							npm -v
						'''
						
						retry(10) {
							sleep 3
							sh '''#!/bin/bash
								export PGPASSWORD=postgres && psql -h dbhost -U ci -c "SELECT 'success';"           
							'''
						}
				}

				stage('Additional Setup') {
					sh '''#!/bin/bash
						export AWS_ACCESS_KEY_ID=${env.AWS_ID_USR}
						export AWS_SECRET_ACCESS_KEY=${env.AWS_ID_PSW}
						env
						chmod +x awsInit.sh && ./awsInit.sh
					'''
				}
				
				stage('Build') {
					echo GIT_BRANCH
				}
			}
		  }
	}
}
