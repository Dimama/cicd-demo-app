pipeline{
    agent{
        label "mvn_agent"
    }
    stages{
        stage("Test"){
            steps{
                sh "echo 'test'"
            }
        }
    }
    post{
        always{
            cleanWs()
        }
    }
}