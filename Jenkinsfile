pipeline {
  agent any

  environment {
    IMAGE_NAME = 'tovalavatar/ci-cd-refresh'
    IMAGE_TAG = 'v1.0.1'
  }

  stages {
    stage('Clone Repo') {
      steps {
        git credentialsId: 'git-creds', url: 'git@github.com:IdanArad/ci-cd-refresh.git'
      }
    }

    stage('Build Image') {
      steps {
        sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
      }
    }

    stage('Push Image') {
      steps {
        withDockerRegistry([ credentialsId: 'docker-hub-creds', url: '' ]) {
          sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
        }
      }
    }

    stage('Deploy with Helm') {
      steps {
        sh '''
          helm upgrade --install ci-cd-refresh ./myapp \
            --set image.repository=$IMAGE_NAME \
            --set image.tag=$IMAGE_TAG
        '''
      }
    }
  }
}

