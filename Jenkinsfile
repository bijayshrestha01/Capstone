pipeline{
    agent any
    stages{
        stage('Lint HTML'){
            steps{
                sh 'echo "Lint check..."'
                sh 'tidy -q -e *.html'
            }
        }

        stage('Docker build') {
            steps {
                script {
		    sh 'Building...'
                    dockerImage = docker.build('beej639/udacity-capstone')
                    docker.withRegistry('', 'dockerhub') {
                        dockerImage.push()
                    }
                }
            }
        }

    }
}
