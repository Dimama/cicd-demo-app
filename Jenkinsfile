pipeline{
    agent {
        label 'mvn_agent'
    }
    stages{
        stage('hello') {
            steps {
                echo 'hello world'
            }
        }
    }
    post{
        always {
            cleanWs()
        }
    }
}