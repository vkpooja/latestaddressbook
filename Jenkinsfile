pipeline{
    agent any
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    stages{
        stage("COMPILE"){
            steps{
                script{
                  echo "COMPILIG THE CODE"
                  sh 'mvn compile'
                }
            }
        }
        stage("UNITTEST"){
         steps{
           script{
               echo "Testing THE CODE"
                sh 'mvn test'
                }
            }
        }
        stage("PACKAGE"){
            steps{
                    script{
                    echo "Packaging THE CODE"
                sh 'mvn package'
        }
    }
}
     
    }
}