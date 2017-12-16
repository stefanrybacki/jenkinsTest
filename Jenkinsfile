pipeline {
  agent {
	dockerfile { dir '.' }
  }
  stages {
    stage('Describe Environment') {
      steps {
        sh """#!/bin/bash
			source ~/.bashrc
			java -version
			gradle -v
		"""
      }
    }
  }
}

