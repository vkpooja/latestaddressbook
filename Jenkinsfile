pipeline {
    agent any
    environment {
        ANSIBLE_SERVER = "52.66.196.95"
    }
    stages {
        stage("copy files to ansible server") {
            steps {
                script {
                    echo "copying all neccessary files to ansible control node"
                    sshagent(['ACM']) {
                        sh "scp -o StrictHostKeyChecking=no ansible/* ec2-user@${ANSIBLE_SERVER}:/home/ec2-user"
                        withCredentials([sshUserPrivateKey(credentialsId: 'Ansible_target', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh 'scp $keyfile ec2-user@$ANSIBLE_SERVER:/home/ec2-user/.ssh/id_rsa'
                        }
                    }
                }
            }
        }
                
        
                                
                        
        }
    }   
