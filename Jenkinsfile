pipeline {
    agent{
        label "mvn_agent"
    }
    stages{
        stage("Run tests"){
            steps{
                sh 'mvn test'
            }
        }
    }
    post{
        always{
            cleanWs()
        }

    }
}