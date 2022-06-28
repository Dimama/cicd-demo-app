pipeline{
    agent{
        label "mvn_agent"
    }
    stages{
        stage("Run tests"){
            steps{
                sh 'mvn test'
            }
        }

        stage("Build maven") {
            environment {
                PACKAGE_VERSION = "${GIT_BRANCH}-${GIT_COMMIT}"
            }
            steps {
                sh 'mvn package -Drevision=$PACKAGE_VERSION -Dapp=cicd-demo-app -Dmaven.test.skip=true'
            }
        }
    }
    post{
        always{
            junit 'target/surefire-reports/**/*.xml'
            cleanWs()
        }
    }
}