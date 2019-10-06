pipeline {
  options {
    ansiColor('xterm')
  }
  agent {
    lable {
      label 'test-terraform'
    }
  }
  stages {
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
    stage ('Confirm apply') {
      when {
        expression {
          GIT_BRANCH == 'master'
        }
      }
      steps {
        input "Apply plan?"
      }
    }
    stage ('Terraform apply') {
      when {
        expression {
          GIT_BRANCH == 'master'
        }
      }
      steps {
        sh "terraform apply -input=false -auto-approve"
      }
    }
  }
}
