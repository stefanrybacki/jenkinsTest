node {
	label 'lvms'
	docker.image('postgres').withRun('-e "POSTGRES_PASSWORD=postgres"') { c ->
		sh 'apt-get install -y zip unzip'
		
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
		
		/* install node */
		sh 'curl -sL https://deb.nodesource.com/setup_8.x | bash'
		sh 'apt-get install -y nodejs'
		sh 'node -v'
		sh 'npm -v'
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