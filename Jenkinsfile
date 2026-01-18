pipeline {
    agent any

    environment {
        DEV_IMAGE  = "padmeshka/devops-build-dev:latest"
        PROD_IMAGE = "padmeshka/devops-build-prod:latest"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        sh 'docker build -t $DEV_IMAGE .'
                    }
                    if (env.BRANCH_NAME == 'master') {
                        sh 'docker build -t $PROD_IMAGE .'
                    }
                }
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        sh 'docker push $DEV_IMAGE'
                    }
                    if (env.BRANCH_NAME == 'master') {
                        sh 'docker push $PROD_IMAGE'
                    }
                }
            }
        }
    }
}

