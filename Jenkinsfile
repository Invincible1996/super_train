pipeline {
    agent any
    stages {
        stage('flutter') {
            steps {
                sh 'export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
                sh 'flutter --version'
                sh 'flutter clean'
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