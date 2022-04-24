pipeline {
    agent {
        label 'mvn_agent'
    }
    
    // tools {
    //     dockerTool 'docker'
    // }
    
    stages {
        stage('Run tests') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build maven') {
            steps {
                sh 'mvn package -Drevision=$GIT_BRANCH-$GIT_COMMIT -Dapp=cicd-demo-app-new -Dmaven.test.skip=true'
            }
        }
        // stage('upload artifact') {
        //     steps {
        //         sh '''curl -v -F maven2.groupId=cicd-demo -F maven2.asset1.extension=jar -F maven2.asset1=@target/cicd-demo-app-new-1.0.0.jar -F maven2.artifactId=cicd-demo-app -F maven2.version=1.0.0 -u admin:password http://nexus:8081/service/rest/v1/components?repository=maven-dev
        //         '''
        //     }
        // }
        // stage('docker') {
        //     steps {
        //         sh 'docker build -t demo-app:latest .'
        //         sh 'docker tag demo-app:latest localhost:5000/demo/demo-app:latest'
        //         sh 'docker login --username admin --password password localhost:5000/repository/demo'
        //         sh 'docker push localhost:5000/demo/demo-app:latest'
        //     }
        // }
    }
    post {
        always {
            junit 'target/surefire-reports/**/*.xml'
            cleanWs()
        }
    }
}
