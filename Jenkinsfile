pipeline{
    agent any
    parameters{
        string(name:'Env',defaultValue:'Test',description:'version to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run TC')
    }
    stages{        
        stage('compile'){
            steps{
                script{
                    echo "Compiling the code"
                }
            }
        }
        stage('UnitTest'){
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps{
                script{
                    echo "Testing the code in ${params.Env} env"
                }
            }
        }
        stage('Package'){
            steps{
                script{
                    echo "Package the code"
                }
            }
        }
    }
}
