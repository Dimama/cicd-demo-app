pipeline{
    agent {
        label 'mvn_agent'
    }
    stages{
        stage('Run tests') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build maven') {
            environment {
                PACKAGE_VERSION = "${GIT_BRANCH}-${GIT_COMMIT}"
            }
            steps {
                sh 'mvn package -Dapp=cicd-demo-app -Drevision=$PACKAGE_VERSION -Dmaven.test.skip=true'
                sh 'ls -la target/'
            }
            
        }
    }
    post{
        always {
            junit 'target/surefire-reports/**/*.xml'
            cleanWs()
        }
    }
}