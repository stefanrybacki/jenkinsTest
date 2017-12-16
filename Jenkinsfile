pipeline {
  agent {
	node {
		label 'lvms'
		docker.image('postgres').withRun('-e "POSTGRES_PASSWORD=postgres"').inside {
			sh """#!/bin/bash
			set -e
			apt-get update && apt-get install -y zip unzip curl debconf-utils git
			
			#install sdk
			curl -s "https://get.sdkman.io" | bash
			source "$HOME/.sdkman/bin/sdkman-init.sh"
			sdk --version

			#install java
			sdk install java 8u152-zulu
			java -version
			
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
  stages {
    stage('Describe Environment') {
      steps {
        sh """
			java -version
			gradle -v
			node -v
			npm -v
			ls
		"""
      }
    }
  }
}