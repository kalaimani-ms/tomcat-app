#!/usr/bin/env groovy

node{
   stage('SCM Checkout'){
     git 'https://github.com/kalaimani-ms/tomcat-app.git'
   }
   stage('Compile-Package'){

      def mvnHome =  tool name: 'Maven', type: 'maven'   
      sh "${mvnHome}/bin/mvn clean package"
	  sh 'mv target/myweb*.war target/newapp.war'
   }
   stage('Build Docker Imager'){
   sh 'docker build -t kalaimanims/mavenapp:0.0.2 .'
   }
   stage('Docker Image Push'){
   withCredentials([string(credentialsId: 'docker-secret-text', variable: 'dockerPassword')]) {
   sh "docker login -u kalaimanims -p ${dockerPassword}"
    }
   sh 'docker push kalaimani-ms/mavenapp:0.0.2'
   }
   stage('Docker deployment'){
   sh 'docker run -d -p 8090:8080 --name tomcattest kalaimanims/mavenapp:0.0.2' 
   }
}
