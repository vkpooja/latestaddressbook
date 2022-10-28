pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    environment{
        BUILD_SERVER_IP="ec2-user@65.2.30.32"
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
        
    }
    stages {
        stage('COMPILE') {
            agent any
            steps {
                script{
                    echo "COMPILING THE CODE"
                    sh 'mvn compile'
                }
                          }
            }
        stage('UnitTest') {
          agent any
           steps {
            script{
                echo "RUNNING UNIT TEST CASES"
                sh 'mvn test'
                    }
                   }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
            }
       stage('Package+BUILD THE DOCKER IMAGE') {
            agent any
            steps {
                script{
                echo "PACKAGING THE CODE"
                sshagent(['ssh-key']) {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                sh "scp -o StrictHostKeyChecking=no server-script.sh ${BUILD_SERVER_IP}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER_IP} 'bash ~/server-script.sh'"  
                sh "ssh ${BUILD_SERVER_IP} sudo docker build -t ${IMAGE_NAME} /home/ec2-user/addressbook"  
                sh  "ssh ${BUILD_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
                sh "ssh ${BUILD_SERVER_IP} sudo docker push ${IMAGE_NAME}"
                 }
              }  
            }
        }
        }
        stage('DEPLOY TO EKS'){
            agent any
            steps{
                script{
                    echo "RUN ON K8S CLUSTER"
                    sh 'envsubst java-mvn-app.yml | sudo kubectl apply -f -'
                }              
            
            }
            }
        }
        }   