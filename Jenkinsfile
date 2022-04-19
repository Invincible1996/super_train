pipeline {
    agent any
    stages {
        stage('flutter') {
            steps {
                sh 'export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
                sh 'fvm use 2.10.5'
                sh 'fvm flutter clean'
                sh 'fvm flutter pub get'
                sh 'ls -h'
            }
        }
         stage('build') {
            steps {
                sh 'fvm flutter build apk'
            }
        }
    }
}