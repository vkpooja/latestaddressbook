pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    environment{
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
          stage("Provision deploy server with TF"){
            environment{
              AWS_ACCESS_KEY_ID =credentials("jenkins_aws_access_key_id")
             AWS_SECRET_ACCESS_KEY=credentials("jenkins_aws_secret_access_key")
            }
             agent any
                   steps{
                       script{
                           dir('terraform'){
                           sh "terraform init"
                           sh "terraform apply --auto-approve"
                           EC2_PUBLIC_IP = sh(
                            script: "terraform output ec2-ip",
                            returnStdout: true
                           ).trim()
                       }
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
                sh "scp -o StrictHostKeyChecking=no server-script.sh ec2-user@${EC2_PUBLIC_IP}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} 'bash ~/server-script.sh'"  
                sh "ssh ec2-user@${EC2_PUBLIC_IP} sudo docker build -t ${IMAGE_NAME} /home/ec2-user/addressbook"  
                sh  "ssh ec2-user@${EC2_PUBLIC_IP} sudo docker login -u $USERNAME -p $PASSWORD"
                sh "ssh ec2-user@${EC2_PUBLIC_IP} sudo docker push ${IMAGE_NAME}"
                sh "ssh ec2-user@${EC2_PUBLIC_IP} sudo docker run -itd -P ${IMAGE_NAME}"
                }
              }  
            }
        }
        }
        }    
    }
    