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
			./tasks/scripts/describe-buildenv.sh
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

		dir(path: 'tasks/scripts') {
			sh '''#!/bin/bash
				source ~/.bashrc
				./generate_html_manuals.sh
			'''
		}

		sh '''#!/bin/bash
			source ~/.bashrc
			gradle -x test build
		'''
		
	  }
    }
  }
}