node {
    
    def mvnHome = tool 'maven-3.8.2'

    
    def dockerImage
    
    def dockerRepoUrl = "localhost:8081"
    def dockerImageName = "spring-boot-mysql"
    def dockerImageTag = "${dockerRepoUrl}/${dockerImageName}:${env.BUILD_NUMBER}"
    
	
    stage('Git SCM clone') { 
      // cloning the code from Git
      git clone 'https://github.com/springframeworkguru/spring-boot-mysql-example"
      // Get the Maven tool.
          
      mvnHome = tool 'maven-3.8.2'
    }    
  
    stage('Build Project') {
      // building the  project through  maven
      sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
    }
	
	stage('Publish Tests Results'){
      parallel(
        publishJunitTestsResultsToJenkins: {
          echo "Publish junit Tests Results"
		      junit '**/target/surefire-reports/TEST-*.xml'
		      archive 'target/*.jar'
        },
        publishJunitTestsResultsToSonar: {
          echo "This is branch b"
                                       }
              )
        }
		stage('Build Docker Image') {
      // build docker image
      sh "whoami"
      sh "ls -all /var/run/docker.sock"
      sh "mv ./target/spring-boot*.jar ./data" 
      
      dockerImage = docker.build("spring-boot-mysql")
  }
   
     stage('Deploy Docker Image'){
      echo "Docker Image Tag Name: ${dockerImageTag}"
      sh "docker login -u admin -p admin123 ${dockerRepoUrl}"
      sh "docker tag ${dockerImageName} ${dockerImageTag}"
      sh "docker push ${dockerImageTag}"
    }
	
	stage('app deployment') {
            steps {
                sh 'kubectl create -f ./kubernetes/app-deployment.yml --record'
                sh 'sleep 2m'
            }
        }
}