pipeline {
    agent any

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: true, description: 'Automatically apply Terraform after plan?')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    git branch: 'feature', url: 'https://github.com/SaranyaLogu132/ls-terraform-jenkins'
                }
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        
        stage('Approval for Apply') {
            when {
                branch 'main'
            }
            steps {
                script {
                    input message: "Approve Terraform Apply?", ok: "Proceed"
                }
            }
        }
        
        stage('Terraform Apply') {
            when {
                branch 'feature'
            }
            steps {
                sh 'terraform apply -input=false tfplan'
            }
        }
    }
}
