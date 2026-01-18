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
                sh 'echo "Building branch: $GIT_BRANCH"'
            }
        }

        stage('Build DEV Image') {
            when {
                expression { env.GIT_BRANCH == 'origin/dev' }
            }
            steps {
                sh 'docker build -t $DEV_IMAGE .'
            }
        }

        stage('Build PROD Image') {
            when {
                expression { env.GIT_BRANCH == 'origin/master' }
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

        stage('Push DEV Image') {
            when {
                expression { env.GIT_BRANCH == 'origin/dev' }
            }
            steps {
                sh 'docker push $DEV_IMAGE'
            }
        }

        stage('Push PROD Image') {
            when {
                expression { env.GIT_BRANCH == 'origin/master' }
            }
            steps {
                sh 'docker push $PROD_IMAGE'
            }
        }
    }
}

