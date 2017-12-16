pipeline {
  agent {
    dockerfile {
      dir '.'
    }
    
  }
  stages {
    stage('Describe Environment') {
      steps {
        sh '''#!/bin/bash
			source ~/.bashrc
			java -version
			gradle -v
		'''
      }
    }
    stage('Build') {
      steps {
        sh '''#!/bin/bash
			source ~/.bashrc
			gradle clean
		'''
        
		dir(path: 'varvis') {
          sh '''#!/bin/bash
			source ~/.bashrc
			gradle :varvis:generateTypeScript
		  '''
          
		  timeout(time: 40, unit: 'MINUTES') {
            sh 'npm install'
          }
          
          timeout(time: 40, unit: 'MINUTES') {
            sh 'npm run build'
          }
          
        }
        
      }
    }
  }
}