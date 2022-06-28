pipeline{
    agent{
        label "mvn_agent"
    }

    parameters {
        string (
            name: 'DOCKER_TAG',
            defaultValue: 'latest',
            description: 'Tag of docker image'
        )
        choice (
            name: 'DOCKER_BUILD',
            choices: ['no', 'yes'],
            description: 'Shall we build and push docker image'
        )
    }

    environment {
        PACKAGE_VERSION = "${GIT_BRANCH}-${GIT_COMMIT}"
    }

    tools {
        dockerTool 'docker'
    }

    stages{
        stage("Run tests"){
            steps{
                sh 'mvn test'
            }
        }

        stage("Build maven") {
            steps {
                sh 'mvn package -Drevision=$PACKAGE_VERSION -Dapp=cicd-demo-app -Dmaven.test.skip=true'
            }
        }

        stage("Upload artifact") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'NEXUS_CRED', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''curl -u $USERNAME:$PASSWORD -v -F maven2.groupId=cicd-demo \
                        -F maven2.asset1.extension=jar \
                        -F maven2.asset1=@target/cicd-demo-app-$PACKAGE_VERSION.jar \
                        -F maven2.artifactId=cicd-demo-app \
                        -F maven2.version=$PACKAGE_VERSION \
                        http://nexus:8081/service/rest/v1/components?repository=maven-dev
                    '''
                }
            }
        }

        stage("Docker build and push") {
            when {
                anyOf {
                    branch 'master'
                    expression { params.DOCKER_BUILD == 'yes' }
                }
            }
            environment {
                TAG = "${params.DOCKER_TAG}"
            }
            steps {
                sh 'docker build -t demo-app:$TAG .'
                sh 'docker tag demo-app:$TAG localhost:5000/demo/demo-app:$TAG'
                withCredentials([usernamePassword(credentialsId: 'NEXUS_CRED', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login --username $USERNAME --password $PASSWORD localhost:5000/repository/demo'
                }
                sh 'docker push localhost:5000/demo/demo-app:$TAG'
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