pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Detect branch name from Jenkins environment
                    def branchName = 'feature'

                    // Clean previous workspace and clone specific branch
                    sh 'rm -rf ls-terraform-jenkins'
                    sh "git clone --single-branch --branch ${branchName} https://github.com/SaranyaLogu132/ls-terraform-jenkins.git"

                    echo "Checked out branch: ${branchName}"
                    env.BRANCH_NAME = branchName
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('ls-terraform-jenkins') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('ls-terraform-jenkins') {
                    sh 'terraform plan -out=tfplan'
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }
            }
        }

        stage('Approval for Apply') {
            when {
                expression { env.BRANCH_NAME == 'main' }
            }
            steps {
                script {
                    input message: "Approve Terraform Apply?", ok: "Proceed"
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { env.BRANCH_NAME == 'main' }
            }
            steps {
                dir('ls-terraform-jenkins') {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }
}
