pipeline{
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    stages{
        stage("COMPILE"){
            agent any
            steps{
                script{
                  echo "COMPILIG THE CODE"
                  sh 'mvn compile'
                }
            }
        }
        stage("UNITTEST"){
            agent {label 'linux_slave'}
         steps{
           script{
               echo "Testing THE CODE"
                sh 'mvn test'
                }
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage("PACKAGE"){
            agent any
            steps{
                    script{
                    echo "Packaging THE CODE"
                sh 'mvn package'
        }
    }
}
     
    }
}