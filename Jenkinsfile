pipeline {
    agent any
    environment {
        azuresp = credentials('azuresp')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/neom-project-ps/neom-terraform.git']])
            }
        }
        stage('Terraform Initialization'){
            steps {
                withCredentials([azureServicePrincipal(credentialsId: 'azuresp', subscriptionIdVariable: 'SUBS_ID', clientIdVariable: 'CLIENT_ID', clientSecretVariable: 'CLIENT_SECRET', tenantIdVariable: 'TENANT_ID')]) {
                sh '''
                terraform init -var subscription_id="$SUBS_ID" -var tenant_id="$TENANT_ID" -var client_id="$CLIENT_ID" -var client_secret="$CLIENT_SECRET"
                '''
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: 'azuresp', subscriptionIdVariable: 'SUBS_ID', clientIdVariable: 'CLIENT_ID', clientSecretVariable: 'CLIENT_SECRET', tenantIdVariable: 'TENANT_ID')]) {
                sh '''
                terraform plan -out=akscluster -var subscription_id="$SUBS_ID" -var tenant_id="$TENANT_ID" -var client_id="$CLIENT_ID" -var client_secret="$CLIENT_SECRET"
                '''
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                sh '''
                terraform apply akscluster
                '''
            }
        }
    }
}