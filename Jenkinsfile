node {
	label 'lvms'
	docker.image('postgres').withRun('-e "POSTGRES_PASSWORD=postgres"') { c ->
        docker.image('postgres').inside("--link ${c.id}:db") {
            /* Wait until mysql service is up */
			/* TODO */
		}
        docker.image('debian:stretch').inside("--link ${c.id}:db") {
            /* install sdk */
			curl -s "https://get.sdkman.io" | bash
			source "$HOME/.sdkman/bin/sdkman-init.sh"
			sdk --version

			/* install java */
			sdk install java 8u151-oracle
			java -v
			
			/* install gradle */
			sdk install gradle 2.12
			gradle -v
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