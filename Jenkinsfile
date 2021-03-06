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
	
	 
	    
	stage('Configure kubectl') {
	    steps {
		withAWS(credentials: 'aws-credentials', region: 'us-west-2') {
		    sh '''
		    echo "Configure kubectl..."
		    aws eks --region us-west-2 update-kubeconfig --name my-devopscapstone
		    kubectl config use-context  arn:aws:eks:us-west-2:537256398869:cluster/my-devopscapstone
	            '''
		}
	    }
        }

	   
	    
	stage('Deploy blue container') {
		steps {
			withAWS(credentials:'aws-credentials', region: 'us-west-2') {
				      sh 'kubectl apply -f ./blue_controller.json'
				
				}
			}
		}
	    
	stage('Deploy green container') {
		steps {
			withAWS(region:'us-west-2', credentials:'aws-credentials') {
				sh '''
					kubectl apply -f ./green_controller.json
				'''
				}
			}
	}
	    
	stage('Create the service in the cluster, redirect to blue') {
		steps {
			withAWS(region:'us-west-2', credentials:'aws-credentials') {
				sh '''
					kubectl apply -f ./blue_service.json
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
			withAWS(region:'us-west-2', credentials:'aws-credentials') {
				sh '''
					kubectl apply -f ./green_service.json
				'''
				}
			}
		}

	 
	
   }   
	    
}
