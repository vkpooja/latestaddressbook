pipeline {
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
     environment{
        IMAGE_NAME='devopstrainer/java-mvn-privaterepos:$BUILD_NUMBER'
        DEV_SERVER_IP='ec2-user@65.2.125.216'
        ACM_IP='ec2-user@52.66.196.95'
        APP_NAME='java-mvn-app'
        AWS_ACCESS_KEY_ID =credentials("AWS_ACCESS_KEY_ID")
        AWS_SECRET_ACCESS_KEY=credentials("AWS_SECRET_ACCESS_KEY")
    }
    stages {
      stage("RUN ansible playbook on ACM"){
            agent any
            steps{
            script{
                echo "RUN THE Ansible playbook"
                echo "Deploying the app to ec2-instance provisioned bt TF"
                sshagent(['ACM']) {
    sh "scp -o StrictHostKeyChecking=no -r ./ansible ${ACM_IP}:/home/ec2-user"
    withCredentials([sshUserPrivateKey(credentialsId: 'Ansible_target',keyFileVariable: 'keyfile',usernameVariable: 'user')]){ 
    sh "scp -o StrictHostKeyChecking=no $keyfile ec2-user@52.66.196.95:/home/ec2-user/.ssh/id_rsa"
    }
    
    //install aws credetials plugin in jenkins
    //withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID',credentialsId:'AWS_CONFIGURE',secretKeyVariable:'AWS_SECRET_ACCESS_KEY')]) {
    sh "ssh -o StrictHostKeyChecking=no ${ACM_IP} 'bash /home/ec2-user/ansible/prepare-ACM.sh ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY} ${IMAGE_NAME}'"
       //     }
        }
        }
        }    
    }
    }
}