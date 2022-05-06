pipeline{
    agent any
    parameters{
        string(name:'Env',defaultValue='Test',description:'version to deploy')

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
