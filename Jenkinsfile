pipeline {
    agent{
        label "mvn_agent"
    }
    stages{
        stage("Test"){
            steps{
                echo "test"
            }
        }
    }
    post{
        always{
            cleanWs()
        }

    }
}