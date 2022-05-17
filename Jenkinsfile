pipeline{
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    environment{
        IMAGE_NAME ='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
        BUILD_SERVER_IP ='ec2-user@3.110.223.109'
        DEPLOY_SERVER_IP='ec2-user@3.110.223.109'
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
            //agent {label 'linux_slave'}
            agent any
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
        stage("PACKAGE+BUILD THE DOCKER IMAGE"){
            agent any
            steps{
            script{
                echo "Packaging THE CODE"
                sshagent(['BUILD_SERVER_KEY']) {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                sh "scp -o StrictHostKeyChecking=no server-script.sh ${BUILD_SERVER_IP}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER_IP} 'bash ~/server-script.sh'"
                sh "ssh sudo docker build -t ${IMAGE_NAME} /home/ec2-user/addressbook"
                sh "ssh sudo docker login -u $USERNAME -p $PASSWORD"
                sh "ssh sudo docker push ${IMAGE_NAME}"
                }
        }
    }
}     
        }
    stage("Deploy the docker image"){
    agent any
        steps{
            script{
                sshagent(['BUILD_SERVER_KEY']) {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                sh "ssh ${DEPLOY_SERVER_IP} sudo yum install docker -y"
                sh "ssh ${DEPLOY_SERVER_IP} sudo systemctl  start docker"
                sh "ssh ${DEPLOY_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
                sh "ssh ${DEPLOY_SERVER_IP} sudo docker run -itd -P ${IMAGE_NAME}"
                    }
                         }
                }
            }
                 }
    }
}
