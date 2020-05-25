pipeline {
	agent any
	stages {

		stage('Create kubernetes cluster') {
			steps {
				withAWS(region:'us-west-2', credentials:'ecr_credentials') {
					sh '''
						eksctl create cluster \
						--name udacitycapstone \
						--version 1.13 \
						--nodegroup-name standard-workers \
						--node-type t2.micro \
						--nodes 2 \
						--nodes-min 1 \
						--nodes-max 3 \
						--node-ami auto \
						--region us-west-2 \
					'''
				}
			}
		}

		

		stage('Create conf file cluster') {
			steps {
				withAWS(region:'us-east-1', credentials:'ecr_credentials') {
					sh '''
						aws eks --region us-west-2 update-kubeconfig --name udacitycapstone
					'''
				}
			}
		}

	}
}
