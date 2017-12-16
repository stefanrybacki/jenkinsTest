node {
	label 'lvms'
	docker.image('postgres').withRun('-e "POSTGRES_PASSWORD=postgres"') { c ->
	  docker.image('postgres').inside("--link ${c.id}:db") {
		sh """#!/bin/bash
		set -e
		apt-get update && apt-get install -y zip unzip curl debconf-utils
		
		#install sdk
		curl -s "https://get.sdkman.io" | bash
		source "$HOME/.sdkman/bin/sdkman-init.sh"
		sdk --version

		#install java
		sdk install java 8u151-zulu
		java -v
		
		#install gradle
		sdk install gradle 2.12
		gradle -v
		
		#install node
		curl -sL https://deb.nodesource.com/setup_8.x | bash
		apt-get install -y nodejs
		node -v
		npm -v
		"""
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