pipeline {
     agent any
  environment{
        REPOSITORY_URI="858990550959.dkr.ecr.ap-south-1.amazonaws.com/repo1"
        //IMAGE_NAME=${REPOSITORY_URI}:${JOB_NAME}_${BUILD_NUMBER}
        AWS_ACCESS_KEY_ID =credentials("AWS_ACCESS_KEY_ID")
         AWS_SECRET_ACCESS_KEY=credentials("AWS_SECRET_ACCESS_KEY")
  }
    stages {   
    //     stage('Select Environment') {
    //         steps{  
    //             script {
    //                 echo 'branch name'
    //                 echo "${env.BRANCH_NAME}"
                    
    //                 if('develop'.equals(env.BRANCH_NAME)){
    //                     echo 'dev environment'
    //                     GLOBAL_ENVIRONMENT = "dev"
    //                     ECR_REGION = "eu-central-1"
    //                     IS_PROD_DEPLOYMENT = false
    //                                         }
    //                 if('release/v2-release'.equals(env.BRANCH_NAME)){
    //                     echo 'stage environment'
    //                     GLOBAL_ENVIRONMENT = "stage"
    //                     ECR_REGION = "eu-central-1"
    //                     IS_PROD_DEPLOYMENT = false
    //                      }
    //             }
    //         }
    //     }
    //     // Building Docker images
    //     stage('Building image and Push to ECR') {
    //         steps{
    //             script {
    //               //sh  "echo ${IMAGE_NAME}"
    //               echo "${env.IMAGE_NAME}"
    //         sh 'aws configure set region ap-south-1'
    //         sh "aws codebuild create-project --name '${JOB_NAME}_${BUILD_NUMBER}' --source type=GITHUB,location=https://github.com/preethid/addressbook.git,buildspec=Build/buildspec.yml --source-version=TEST --artifacts type=NO_ARTIFACTS --environment type=LINUX_CONTAINER,image='aws/codebuild/amazonlinux2-x86_64-standard:4.0',computeType=BUILD_GENERAL1_SMALL,privilegedMode=true --service-role arn:aws:iam::858990550959:role/service-role/codebuild-TEST-service-role"
    // awsCodeBuild credentialsType: 'keys', projectName: '${JOB_NAME}_${BUILD_NUMBER}', region: 'ap-south-1', sourceVersion: 'TEST',sourceControlType: 'project'
              
    //             }
    //         }
    //     }
        stage('Update the docker image name in K8s deployment'){
            steps{
                    script{
                        echo "RUN THE APP ON K8S CLUSTER"
                        //sh 'git clone https://github.com/preethid/addressbook.git'
                        sh "git checkout TEST"
                          sh 'envsubst < k8s-deploy.yml > k8s/k8s-deploy.yml'
                        withCredentials([usernamePassword(credentialsId: 'github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        def encodedPassword = URLEncoder.encode("$GIT_PASSWORD",'UTF-8')
                                 
                                 sh "git config user.email admin@example.com"
                                 sh "git config user.name example"
                                 sh "git add ."
                                 sh "git commit -m 'Triggered Build: ${env.BUILD_NUMBER}'"
                                 //sh "git push https://${GIT_USERNAME}:${encodedPassword}@github.com/${GIT_USERNAME}/addressbook.git"
                                 sh "https://github.com/preethid/addressbook.git"
                              }
                      
                        //sh 'git add .'
                        // sh 'git checkout TEST'
                        // sh 'git config --global user.name "Mona Lisa"'
                        // sh 'git config --global user.email "mona@gmail.com"'
                        // sh 'git commit -a -m "k8s files updated"'
                        // sh 'git push origin TEST'
                }

    }
        }
    stage('run the k8s deployment files'){
        steps{
                    script{
                        echo "RUN THE APP ON K8S CLUSTER"
                        //sh 'envsubst < java-mvn-app.yml >  k8s/java-mvn-app.yml'
                }

    }
}
}
}
