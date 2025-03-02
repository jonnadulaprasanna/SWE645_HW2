pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub') 
    }
    stages {
        stage('Build') {
            steps {
                sh 'rm -rf *.war'  
                sh 'jar cvf studentsurvey.war .'  
                sh 'docker build -t prasanna0307/studentsurvey:latest .'  
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
               
                sh 'kubectl set image deployment/deployswehw2 container-0=prasanna0307/studentsurvey:latest -n default'
                sh 'kubectl rollout status deployment/deployswehw2 -n default'
            }
        }
    }

    post {
        always {
            sh 'docker logout'  
        }
    }
}
