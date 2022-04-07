pipeline {
    agent any
    stages {
        stage('flutter') {
            steps {
                sh 'export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
            }
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