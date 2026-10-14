pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker build --build-arg VERSION=green -t myapp:v2 .'
                sh 'sudo -n -u ubuntu /usr/local/bin/minikube image load myapp:v2'
            }
        }

        stage('Deploy Green') {
            steps {
                sh 'sudo -n -u ubuntu /usr/local/bin/kubectl apply -f deployment-green.yaml'
                sh 'sudo -n -u ubuntu /usr/local/bin/kubectl rollout status deployment/myapp-green --timeout=180s'
            }
        }

        stage('Switch Traffic') {
            steps {
                input 'Switch to Green?'
                sh '''sudo -n -u ubuntu /usr/local/bin/kubectl patch service myapp-service \
                    -p '{"spec":{"selector":{"app":"myapp","color":"green"}}}' '''
            }
        }
    }
}
