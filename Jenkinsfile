pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
		sh 'echo "Lint check..."'
                sh 'tidy -q -e *.html'
            }
        }
	    
	stage('Build Docker Image') {
   	    steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
		    sh 'echo "Building Docker Image..."'
     	    	    sh 'docker build -t beej639/devopsproject .'
		}
            }
        }
	    
	stage('Push Image To Dockerhub') {
   	    steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
		    sh 'echo "Pushing Docker Image..."'
     	    	    sh '''
                        docker login -u $USERNAME -p $PASSWORD
			docker push beej639/devopsproject
                    '''
		}
            }
        }
	
	    
	stage('Set current kubectl context') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws-kubectl') {
					sh '''
						kubectl config current-context
						kubectl config get-contexts
						kubectl config use-context jenkins@devopsproject.us-west-2.eksctl.io
					'''
				}
			}
	}
	    
	stage('Deploy blue container') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws-kubectl') {
					sh '''
						kubectl apply -f ./blue_controller.yml
					'''
				}
			}
		}
	 
	
   }   
	    
}
