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

        stage('Build Docker Image (DEV)') {
            when {
                branch 'dev'
            }
            steps {
                sh 'docker build -t $DEV_IMAGE .'
            }
        }

        stage('Build Docker Image (PROD)') {
            when {
                branch 'master'
            }
            steps {
                sh 'docker build -t $PROD_IMAGE .'
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

        stage('Push Docker Image (DEV)') {
            when {
                branch 'dev'
            }
            steps {
                sh 'docker push $DEV_IMAGE'
            }
        }

        stage('Push Docker Image (PROD)') {
            when {
                branch 'master'
            }
            steps {
                sh 'docker push $PROD_IMAGE'
            }
        }
    }
}

