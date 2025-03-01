pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub') // Using DockerHub credentials stored in Jenkins
    }
    stages {
        stage('Build') {
            steps {
                sh 'rm -rf *.war'  // Assuming you meant to clean up old WAR files
                sh 'jar cvf studentsurvey.war .'  // Create the WAR file
                sh 'docker build -t prasanna0307/studentsurvey:latest .'  // Build Docker image
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                sh 'docker push prasanna0307/studentsurvey:latest'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Update the deployment image and monitor the rollout
                sh 'kubectl set image deployment/deployswehw2 container-0=prasanna0307/studentsurvey:latest -n default'
                sh 'kubectl rollout status deployment/deployswehw2 -n default'
            }
        }
    }

    post {
        always {
            sh 'docker logout'  // Always logout from DockerHub after the pipeline
        }
    }
}
