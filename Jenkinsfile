pipeline {
    agent {
        label 'mvn_agent'
    }
    
    parameters {
        choice (
            name: 'DOCKER_BUILD',
            choices: ['no', 'yes'],
            description: 'Shall we build and push docker image'
        )
        string (
            name: 'DOCKER_TAG',
            defaultValue: 'latest',
            description: 'Tag of docker image'
        )
    }

    tools {
        dockerTool 'docker'
    }

    environment {
        PACKAGE_VERSION = "${GIT_BRANCH}-${GIT_COMMIT}"
    }

    stages {

        stage('Run tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build maven') {
            steps {
                sh 'mvn package -Drevision=$PACKAGE_VERSION -Dapp=cicd-demo-app -Dmaven.test.skip=true'
            }
        }

        stage('Upload jar artifact') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'NEXUS_USER', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''curl -v -F maven2.groupId=cicd-demo \
                        -F maven2.asset1.extension=jar \
                        -F maven2.asset1=@target/cicd-demo-app-$PACKAGE_VERSION.jar \
                        -F maven2.artifactId=cicd-demo-app \
                        -F maven2.version=$PACKAGE_VERSION \
                        -u $USERNAME:$PASSWORD http://nexus:8081/service/rest/v1/components?repository=maven-dev
                    '''
                }

            }
        }

        stage('Docker build and push') {
            when {
                anyOf {
                    branch 'develop'
                    expression { params.DOCKER_BUILD == 'yes' }
                }
            }
            environment {
                TAG = "${params.DOCKER_TAG}"
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'NEXUS_USER', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker build -t demo-app:$TAG .'
                    sh 'docker tag demo-app:latest localhost:5000/demo/demo-app:$TAG'
                    sh 'docker login --username $USERNAME --password $PASSWORD localhost:5000/repository/demo'
                    sh 'docker push localhost:5000/demo/demo-app:$TAG'
                }

            }
        }
    }

    post {
        always {
            junit 'target/surefire-reports/**/*.xml'
            cleanWs()
        }
    }
}
