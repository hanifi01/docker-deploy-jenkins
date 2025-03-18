pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Building the Docker image
                    sh 'docker build -t myapp:latest .'
                }
            }
        }

        stage('Deploy to Docker') {
            steps {
                script {
                    // Running the Docker container
                    sh 'docker run -d -p 8080:80 myapp:latest'
                }
            }
        }
    }
}