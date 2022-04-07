pipeline {
    agent any
    stages {
        stage('flutter') {
            steps {
                sh 'flutter --version'
            }
            steps {
                sh 'flutter clean'
            }
             steps {
                sh 'flutter pub get'
            }
        }
         stage('build') {
            steps {
                sh 'flutter build apk'
            }
        }
    }
}