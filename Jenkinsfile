pipeline {
  agent {
	dockerfile { dir '.' }
  }
  stages {
    stage('Describe Environment') {
      steps {
        sh """
			gradle -v
			java -version
		"""
      }
    }
  }
}

