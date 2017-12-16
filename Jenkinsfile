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
gradle clean'''
        dir(path: 'varvis') {
          sh '''#!/bin/bash
gradle :varvis:generateTypeScript'''
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