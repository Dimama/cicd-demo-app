pipeline{
    agent {
        label 'mvn_agent'
    }
    stages{
        steps {
            echo 'hello world'
        }
    }
    post{
        always {
            cleanWs()
        }
    }
}