pipeline {
  agent any

  environment {
    SVC_ACCOUNT_KEY = credentials('tfauth')
  }

  stages {
    stage('Checkin') {
      steps {
        sh 'mkdir -p creds'
        sh 'echo $SVC_ACCOUNT_KEY | base64 -d > /tmp/serviceaccount.json'
        sh "export GOOGLE_CLOUD_KEYFILE_JSON=/tmp/serviceaccount.json"
      }
    }
    stage ('Terraform init') {
      steps {
        sh "terraform init"
      }
    }
    stage ('Terraform plan') {
      steps {
        sh "terraform plan -input=false"
      }
    }
    stage ('Terraform apply') {
      steps {
        sh "terraform apply -input=false -auto-approve"
      }
    }
    stage('Checkout') {
      steps {
        sh 'rm /tmp/serviceaccount.json'
      }
    }
  }

}
