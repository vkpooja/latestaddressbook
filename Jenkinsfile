pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    environment{
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
        ACM_IP='ec2-user@13.233.115.245'
        AWS_ACCESS_KEY_ID =credentials("jenkins_aws_access_key_id")
        AWS_SECRET_ACCESS_KEY=credentials("jenkins_aws_secret_access_key")
        DOCKER_REG_PASSWORD=credentials("DOCKER_REG_PASSWORD")
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
              agent any
                   steps{
                       script{
                           dir('terraform'){
                           sh "terraform init"
                           sh "terraform apply --auto-approve"
                           ANSIBLE_TARGET_PUBLIC_IP = sh(
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
                 sh "scp -o StrictHostKeyChecking=no ansible/* ${ACM_IP}:/home/ec2-user"
                 withCredentials([sshUserPrivateKey(credentialsId: 'Ansible_target',keyFileVariable: 'keyfile',usernameVariable: 'user')]){ 
                    sh "scp $keyfile ${ACM_IP}:/home/ec2-user/.ssh/id_rsa"    
                    }
            sh "ssh -o StrictHostKeyChecking=no ${ACM_IP} bash /home/ec2-user/prepare-ACM.sh ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY} ${DOCKER_REG_PASSWORD} ${IMAGE_NAME}"
                }
            }
        }
        }
        }    
    }
    