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
            environment {
                TAG = "${params.DOCKER_TAG}"
            }
            steps {
                sh 'docker build -t demo-app:$TAG .'
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