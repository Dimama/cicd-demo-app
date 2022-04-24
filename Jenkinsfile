pipeline {
    agent {
        label 'mvn_agent'
    }
    
    // tools {
    //     dockerTool 'docker'
    // }
    
    stages {
        stage('test') {
            sh 'env'
            sh 'mvn test'
        }
        // stage('git') {
        //     steps {
        //         git branch: 'develop', url: 'https://github.com/Dimama/cicd-demo-app.git'
        //         sh 'pwd && ls -l'
        //     }
        // }
        // stage('test') {
        //     steps {
        //         sh 'ls -la'
        //         sh 'mvn test'
        //     }
        // }
        // stage('build maven') {
        //     steps {
        //         sh 'echo $GIT_COMMIT'
        //         sh 'mvn package -Drevision=1.0.0 -Dapp=cicd-demo-app-new -Dmaven.test.skip=true'
        //     }
        // }
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
