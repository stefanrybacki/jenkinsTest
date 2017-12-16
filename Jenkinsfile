pipeline {
  agent {
	dockerfile { dir '.' }
  }
  stages {
    stage('Describe Environment') {
      steps {
        sh """
		    echo $PATH
			ls -la
			node -v
			npm -v
			locate java
			locate gradle
			java -version
			gradle -v
		"""
      }
    }
  }
}

