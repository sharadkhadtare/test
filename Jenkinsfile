pipeline {
  agent any

  environment {
    SVC_ACCOUNT_KEY = credentials('tfauth')
  }

  stages {
    stage ('Checkout') {
      steps {
        sh 'mkdir -p creds'
        sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ./creds/serviceaccount.json'
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
        sh "terraform destroy -input=false -auto-approve"
      }
    }
  }
}
