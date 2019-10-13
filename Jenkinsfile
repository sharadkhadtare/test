pipeline {
  agent any

  environment {
    SVC_ACCOUNT_KEY = credentials('tfauth')
  }

  stages {
    stage('Checkin') {
      steps {
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
        sh "terraform plan -input=false -target=cloud-sql-gdpr-us"
      }
    }
    stage ('Terraform apply') {
      steps {
        sh "terraform destroy -input=false -auto-approve -target=cloud-sql-gdpr-us"
      }
    }
    stage('Checkout') {
      steps {
        sh 'rm /tmp/serviceaccount.json'
      }
    }
  }

}
