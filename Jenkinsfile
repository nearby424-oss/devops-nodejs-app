pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "developer1245/devops-app"
    }

    stages {

        stage('Clone Code') {
            steps {
                git branch: 'main', credentialsId: 'git-credits', url: 'https://github.com/nearby424-oss/Nodejs-app.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                dir('app'){
                sh 'npm install'
                }
            }
        }

        stage('Test') {
            steps {
                sh 'echo "Run tests here"'
            }
        }

        stage('Security Scan') {
            steps {
                sh 'npm audit || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-credits',
                    usernameVariable: 'USER', passwordVariable: 'PASS')]) {

                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
                }
            }
        }
        stage('Update K8s Manifest') {
            steps {
            withCredentials([usernamePassword(
            credentialsId: 'github-creds',
            usernameVariable: 'GIT_USER',
            passwordVariable: 'GIT_PASS'
        )]) {

            sh '''
            sed -i "s|IMAGE_TAG|'"$BUILD_NUMBER"'|g" k8s/deployment.yaml

            git config --global user.email "nearby424@gmail.com"
            git config --global user.name "nearby424-oss"

            git add k8s/deployment.yaml
            git commit -m "Update image tag to '"$BUILD_NUMBER"'" || echo "No changes to commit"

            git push https://$GIT_USER:$GIT_PASS@github.com/nearby424-oss/Nodejs-app.git main
            '''
            }
        }
        
    }
}
