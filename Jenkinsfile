pipeline{
    agent any
    stages{
        stage('Lint HTML'){
            steps{
                sh 'echo "Lint check..."'
                sh 'tidy -q -e *.html'
            }
        }

        stage('Build Docker Image'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
                    sh 'echo "Building Docker Image..."'
                    sh 'docker build -t beej639/bijayudacitycapstone .'
                }
            }
        }

        stage('Push Image To Dockerhub'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
                    sh 'echo "Pushing Docker Image..."'
                    sh '''
                        docker login -u $USERNAME -p $PASSWORD
                        docker push beej639/bijayudacitycapstone
                    '''    
                }
            }
        }

        stage('Create k8s cluster'){
            steps{
                withAWS(credentials: 'aws-kubectl', region: 'us-west-2'){
                    sh 'echo ""Create k8s cluster..."'
                    sh '''
                        eksctl create cluster \
                        --name bijayudacitycapstone \
                        --version 1.14 \
                        --region us-west-2 \
                        --nodegroup-name standard-workers \
                        --node-type t2.micro \
                        --nodes 2 \
                        --nodes-min 1 \
                        --nodes-max 3 \
                        --managed
                    '''    


                }
            }
        }

        stage('Configure kubectl'){
            steps{
                withAWS(credentials: 'aws-static', region: 'us-west-2'){
                    sh 'echo "Configure kubectl..."'
                    sh 'aws eks --region us-west-2 update-kubeconfig --name bijayudacitycapstone'
                }
            }
        }

        stage('Deploy blue container'){
            steps{
                withAWS(credentials: 'aws-static', region: 'us-west-2'){
                    sh 'echo "Deploy blue container..."'
                    sh 'kubectl apply -f ./blue/blue.yaml'
                }
            }
        }

        stage('Deploy green container'){
            steps{
                withAWS(credentials: 'aws-static', region:'us-west-2'){
                    sh 'echo "Deploy green container..."'
                    sh 'kubectl apply -f ./green/green.yaml'
                }
            }
        }

        stage('Create blue service'){
            stages{
                withAWS(credentials: 'aws-static', region: 'us-west-2'){
                    sh 'echo "Create blue service..."'
                    sh 'kubectl apply -f ./blue/blue_service.yaml'
                }
            }
        }

        stage('Update service to green'){
            steps{
                withAWS(credential: 'aws-static', region: 'us-west-2'){
                    sh 'echo "Update service to green..."'
                    sh 'kubectl apply -f ./green/green_service.yaml'
                }
            }
        }
    }
}
