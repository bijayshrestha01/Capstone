pipeline{
    agent any
    stages{
        stage('Lint HTML'){
            steps{
                sh 'echo "Lint check..."'
                sh 'tidy -q -e *.html'
            }
        }

        
    }
}
