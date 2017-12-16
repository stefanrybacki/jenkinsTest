node {
	label 'lvms'
	docker.image('postgres').withRun('-e "POSTGRES_PASSWORD=postgres"') { c ->
        docker.image('postgres').inside("--link ${c.id}:db") {
            /* Wait until mysql service is up */
			/* TODO */
		}
        docker.image('debian:stretch').inside("--link ${c.id}:db") {
            /* install sdk */
			sh 'curl -s "https://get.sdkman.io" | bash'
			sh 'source "$HOME/.sdkman/bin/sdkman-init.sh"'
			sh 'sdk --version'

			/* install java */
			sh 'sdk install java 8u151-oracle'
			sh 'java -v'
			
			/* install gradle */
			sh 'sdk install gradle 2.12'
			sh 'gradle -v'
        }
    }
}

pipeline {
  agent {
    node {
      label 'lvms'
    }
    
  }
  stages {
    stage('Describe Environment') {
      steps {
        echo 'Hello World'
      }
    }
  }
}