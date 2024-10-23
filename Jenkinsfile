pipeline {
    agent any

    environment {
        AWS_ECR_REPO_NAME = 'spring-petclinic'  // Replace with your ECR repository name
        AWS_REGION = 'us-east-1'                      // Replace with your AWS region
        DOCKER_IMAGE = "${AWS_ECR_REPO_NAME}:${env.BUILD_NUMBER}"
        AWS_CREDENTIALS_ID = 'aws-credentials-id'     // Jenkins credentials ID for AWS
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the develop branch
                git branch: 'develop', url: 'https://github.com/EltonEBM/spring-petclinic.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile
                script {
                    dockerImage = docker.build("${AWS_ECR_REPO_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                // Login to AWS ECR using AWS CLI
                script {
                    withCredentials([usernamePassword(credentialsId: "${AWS_CREDENTIALS_ID}", 
                                                    usernameVariable: 'AWS_ACCESS_KEY_ID', 
                                                    passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                            aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                            aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                            aws configure set region ${AWS_REGION}
                            $(aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com)
                        '''
                    }
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                // Push the built Docker image to AWS ECR
                script {
                    sh "docker tag ${AWS_ECR_REPO_NAME}:${env.BUILD_NUMBER} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${AWS_ECR_REPO_NAME}:${env.BUILD_NUMBER}"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${AWS_ECR_REPO_NAME}:${env.BUILD_NUMBER}"
                }
            }
        }
    }

    post {
        always {
            // Clean up the Docker image locally to save space
            sh "docker rmi ${AWS_ECR_REPO_NAME}:${env.BUILD_NUMBER} || true"
            sh "docker rmi ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${AWS_ECR_REPO_NAME}:${env.BUILD_NUMBER} || true"
        }
    }
}
