pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        sh export GOOGLE_CLOUD_KEYFILE_JSON="/tmp/accounts.json"
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
