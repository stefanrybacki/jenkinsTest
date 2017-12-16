pipeline {
  agent {
	dockerfile { dir '.' }
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

