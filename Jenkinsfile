def img

pipeline {
    
     environment {
        registry = "ashok2931mail/dockerjenkins_project1" //To push an image to Docker Hub, you must first name your local image using your Docker Hub username and the repository name that you created through Docker Hub on the web.
        registryCredential = 'dockerhub_creds'
        dockerImage = ''
    }
    agent any
    
    tools {
        maven 'maven3'
    }

    stages{
        
        stage('SCM'){
            
            steps{
                echo 'Starting to retrieve the source code fro Git Hub'
                git credentialsId: 'githubcreds',
                url: 'https://github.com/ashok2931mail/dockerjenkins_demo1.git'
                
            }
        }
        stage('Maven Build'){
            
            steps{
                echo 'Starting to build using Maven'
                sh "mvn clean package"
            }
            
        }
        
        stage ('Stop previous running container in Jenkins node(Development) '){
            steps{
	            echo 'Stop previous running container in Jenkins node(Development)'

                sh returnStatus: true, script: 'docker stop $(docker ps -a | grep ${JOB_NAME} | awk \'{print $1}\')'
                sh returnStatus: true, script: 'docker rmi $(docker images | grep ${registry} | awk \'{print $3}\') --force' //this will delete all images
                sh returnStatus: true, script: 'docker rm ${JOB_NAME}'
            }
        }

        

        stage('Build Image') {
            steps {
		        echo 'Starting to build docker image'
                script {
                     img = registry + ":${env.BUILD_ID}"

                     println ("${img}")
                     dockerImage = docker.build("${img}")

                   
                }
            }
        }
        
        stage('Test - Run Docker Container on Jenkins node') {
           steps {
                 echo 'Running container on jenkins node'
                sh label: '', script: "docker run -d --name ${JOB_NAME} -p 8888:8080 ${img}"
          }
        }


        
         stage('Push Image To DockerHub') {
            steps {
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com ', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }

        

        
    }
    
}
