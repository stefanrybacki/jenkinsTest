node {
    checkout scm

	withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ID']]) { 
	  def dbPass='postgres'
	  def dbUser='ci'
	  def dbHost='dbhost'
	  withEnv(["LVMS_DATABASE_USERNAME=$dbUser",
	           "LVMS_DATABASE_PASSWORD=$dbPass",
			   "SPRING_DATASOURCE_URL=$dbHost"
	  ]) {	
		  docker.image('postgres').withRun("-e POSTGRES_PASSWORD=$dbPass -e POSTGRES_USER=$dbUser") { c ->
				def ciEnv = docker.build 'ci-environment'  
				ciEnv.inside("--link ${c.id}:$dbHost") {

				stage('Init') {
						sh '''#!/bin/bash
							java -version
							gradle -v
							node -v
							npm -v
							locale
						'''
						
						retry(10) {
							sleep 3
							sh '''#!/bin/bash
								locale
								export PGPASSWORD=$LVMS_DATABASE_PASSWORD && psql -h $SPRING_DATASOURCE_URL -U $LVMS_DATABASE_USERNAME -c "SELECT 'success';"           
							'''
						}
				}

				stage('Additional Setup') {
					sh '''#!/bin/bash
						chmod +x awsInit.sh && ./awsInit.sh
					'''
				}
				
				stage('Build') {
					env
					echo BRANCH_NAME
				}
			}
		  }
		}
	}
}
