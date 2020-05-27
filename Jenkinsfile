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
     	    	    sh '''
			docker build -t beej639/udacitydevopscapstone .
                    '''
		}
            }
        }
	    
	stage('Push Image To Dockerhub') {
   	    steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
		    sh 'echo "Pushing Docker Image..."'
     	    	    sh '''
                        docker login -u $USERNAME -p $PASSWORD
			docker push beej639/udacitydevopscapstone
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
			kubectl config use-context current-context
			'''
		    }
	      }
	}

	   
	    
	stage('Deploy blue container') {
		steps {
			withAWS(region:'us-west-2', credentials:'aws-kubectl') {
				sh '''
					kubectl apply -f ./blue_controller.json
				'''
				}
			}
		}
	    
	stage('Deploy green container') {
		steps {
			withAWS(region:'us-west-2', credentials:'aws-kubectl') {
				sh '''
					echo "Complete..."
				'''
				}
			}
	}
	    
	stage('Create the service in the cluster, redirect to blue') {
		steps {
			withAWS(region:'us-west-2', credentials:'aws-kubectl') {
				sh '''
					echo "Complete..."
				'''
				}
			}
		}

	stage('Wait user approve') {
            steps {
                input "Ready to redirect traffic to green?"
            }
        }

	stage('Create the service in the cluster, redirect to green') {
		steps {
			withAWS(region:'us-east-2', credentials:'aws-kubectl') {
				sh '''
					kubectl apply -f ./green_service.json
				'''
				}
			}
		}

	 
	
   }   
	    
}
