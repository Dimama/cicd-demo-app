pipeline{
    agent {
        label 'mvn_agent'
    }
    stages{
        stage {
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